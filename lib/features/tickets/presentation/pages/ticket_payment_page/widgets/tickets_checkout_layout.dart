import 'package:faro_clean_tdd/core/util/show_result_message_snackbar.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/tickets/data/models/ticket_model.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/create_ticket/create_ticket_provider.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/create_ticket/state/create_ticket_state.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/fetch_tickets/fetch_tickets_provider.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/user_auth/user_provider.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/widgets/usecase_elevated_button.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/pages/ticket_payment_page/widgets/buy_ticket_card.dart';
import 'package:faro_clean_tdd/features/tickets/domain/entities/ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'my_spacer.dart';

class TicketsCheckoutLayout extends ConsumerStatefulWidget {
  const TicketsCheckoutLayout({
    super.key,
    required this.isFree,
    required this.isGoldTicketPresent,
    required this.isPlatinumTicketPresent,
    required this.event,
  });

  final bool isFree;
  final bool isGoldTicketPresent;
  final bool isPlatinumTicketPresent;
  final Event event;

  @override
  ConsumerState<TicketsCheckoutLayout> createState() =>
      _TicketsCheckoutLayoutState();
}

class _TicketsCheckoutLayoutState extends ConsumerState<TicketsCheckoutLayout> {
  final List<TicketModel> tickets = [];
  int? totalAmount;

  @override
  Widget build(BuildContext context) {
    final int userId = ref.read(userInfoProvider)["user_id"];

    final int standardTicketQuantity =
        tickets.where((element) => element.type == Type.standard).length;
    final int goldTicketQuantity =
        tickets.where((element) => element.type == Type.gold).length;
    final int platinumTicketQuantity =
        tickets.where((element) => element.type == Type.platinum).length;

    final bool isEnoughStandardTicket =
        standardTicketQuantity < widget.event.standardTicketCountLeft;
    final bool isEnoughGoldTicket =
        goldTicketQuantity < (widget.event.goldTicketCountLeft ?? 0);
    final bool isEnoughPlatinumTicket =
        platinumTicketQuantity < (widget.event.platinumTicketCountLeft ?? 0);

    if (!widget.isFree) {
      totalAmount = tickets.fold<int>(
          0, (previousValue, element) => previousValue + (element.price ?? 0));
    }

    return Column(
      children: [
        BuyTicketCard(
          event: widget.event,
          ticketType: Type.standard,
          ticketQuantity: standardTicketQuantity,
          incrOrDecr: (value) {
            if (value) {
              if (widget.isFree) {
                standardTicketQuantity >= 1
                    ? showResultMessageSnackbar(
                        context: context,
                        message: "Les évènements gratuits sont à ticket unique")
                    : addTicket(
                        type: Type.standard,
                        price: widget.event.standardTicketPrice,
                        description: widget.event.standardTicketDescription,
                        eventId: widget.event.id!,
                        userId: userId);
                return;
              }
              if (isEnoughStandardTicket) {
                addTicket(
                    type: Type.standard,
                    price: widget.event.standardTicketPrice,
                    description: widget.event.standardTicketDescription,
                    eventId: widget.event.id!,
                    userId: userId);
              } else {
                showResultMessageSnackbar(
                    context: context,
                    message: "Pas assez de ticket disponible.");
              }
            } else {
              standardTicketQuantity <= 0
                  ? null
                  : removeTicket(type: Type.standard);
            }
          },
        ),
        if (widget.isGoldTicketPresent) const MySpacer(),
        if (widget.isGoldTicketPresent)
          BuyTicketCard(
            ticketQuantity: goldTicketQuantity,
            event: widget.event,
            ticketType: Type.gold,
            incrOrDecr: (value) {
              if (value) {
                if (isEnoughGoldTicket) {
                  addTicket(
                      type: Type.gold,
                      price: widget.event.goldTicketPrice,
                      description: widget.event.goldTicketDescription!,
                      eventId: widget.event.id!,
                      userId: userId);
                } else {
                  showResultMessageSnackbar(
                      context: context,
                      message: "Pas assez de ticket disponible.");
                }
              } else {
                goldTicketQuantity <= 0 ? null : removeTicket(type: Type.gold);
              }
            },
          ),
        if (widget.isPlatinumTicketPresent) const MySpacer(),
        if (widget.isPlatinumTicketPresent)
          BuyTicketCard(
            ticketQuantity: platinumTicketQuantity,
            event: widget.event,
            ticketType: Type.platinum,
            incrOrDecr: (value) {
              if (value) {
                if (isEnoughPlatinumTicket) {
                  addTicket(
                      type: Type.platinum,
                      price: widget.event.platinumTicketPrice,
                      description: widget.event.platinumTicketDescription!,
                      eventId: widget.event.id!,
                      userId: userId);
                } else {
                  showResultMessageSnackbar(
                      context: context,
                      message: "Pas assez de ticket disponible.");
                }
              } else {
                platinumTicketQuantity <= 0
                    ? null
                    : removeTicket(type: Type.platinum);
              }
            },
          ),
        const MySpacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Montant:",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Center(
                  child: Text(
                    totalAmount == null ? "Gratuit" : "$totalAmount XOF",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, child) {
            return UsecaseElevatedButton(
              usecaseTitle: widget.isFree
                  ? "Reservez votre billet"
                  : "Réservez vos billets",
              onUsecaseCall: () async {
                if (tickets.isNotEmpty) {
                  for (final ticket in tickets) {
                    final result = await ref
                        .read(createTicketProvider.notifier)
                        .createTicket(ticket: ticket);
                    if (context.mounted) {
                      annonceResult(
                          context: context, createTicketState: result);
                    }
                  }
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                } else {
                  if (context.mounted) {
                    showResultMessageSnackbar(
                      context: context,
                      message: "Vous n'avez pas sélectionné de billet",
                    );
                  }
                }
              },
            );
          },
        )
      ],
    );
  }

  void annonceResult(
      {required CreateTicketState createTicketState,
      required BuildContext context}) {
    final isSuccess = createTicketState is Loaded && context.mounted;
    final isError = createTicketState is Error && context.mounted;

    if (isSuccess) {
      final ftState = ref.read(fetchTicketsProvider);
      ref.read(fetchTicketsProvider.notifier).addTicket(
            ticket: createTicketState.ticket,
            fetchTicketsState: ftState,
          );
      showResultMessageSnackbar(
        context: context,
        message: createTicketState.message,
      );
    }

    if (isError) {
      showResultMessageSnackbar(
        context: context,
        message: createTicketState.message,
      );
    }
  }

  void addTicket({
    required Type type,
    required String description,
    required int eventId,
    required int userId,
    required int? price,
  }) {
    setState(() {
      tickets.add(TicketModel(
        id: null,
        type: type,
        description: description,
        eventId: eventId,
        userId: userId,
        qrCodeUrl: '',
        price: price,
        verified: false,
      ));
    });
  }

  void removeTicket({
    required Type type,
  }) {
    setState(() {
      final int index = tickets.indexWhere((element) => element.type == type);
      tickets.removeAt(index);
    });
  }
}
