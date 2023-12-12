import 'package:faro_clean_tdd/core/util/show_result_message_snackbar.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/tickets/data/models/ticket_model.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/create_ticket/create_ticket_provider.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/create_ticket/state/create_ticket_state.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/fetch_tickets/fetch_tickets_provider.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/user_provider.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/widgets/usecase_elevated_button.dart';
import 'package:faro_clean_tdd/pages/ticket_payment_page/widgets/buy_ticket_card.dart';
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
        goldTicketQuantity < widget.event.goldTicketCountLeft!;
    final bool isEnoughPlatinumTicket =
        platinumTicketQuantity < widget.event.platinumTicketCountLeft!;

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
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Container(
              height: 65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Center(
                  child: Text(
                    totalAmount == null ? "Gratuit" : "$totalAmount XOF",
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        if (!widget.isFree)
          UsecaseElevatedButton(
              usecaseTitle: "Achetez vos billets", onUsecaseCall: () {}),
        if (widget.isFree)
          Consumer(
            builder: (BuildContext context, WidgetRef ref, child) {
              return UsecaseElevatedButton(
                usecaseTitle: "Reservez votre billet",
                onUsecaseCall: () async {
                  if (standardTicketQuantity == 1) {
                    final result = await ref
                        .read(createTicketProvider.notifier)
                        .createTicket(
                          ticket: TicketModel(
                              id: null,
                              type: Type.standard,
                              description:
                                  widget.event.standardTicketDescription,
                              eventId: widget.event.id!,
                              userId: ref.read(userInfoProvider)["user_id"],
                              qrCodeUrl: '',
                              price: widget.event.standardTicketPrice,
                              verified: false),
                        );
                    switch (result) {
                      case Loaded():
                        if (context.mounted) {
                          final fetchTicketState =
                              ref.read(fetchTicketsProvider);
                          ref.read(fetchTicketsProvider.notifier).addTicket(
                              ticket: result.ticket,
                              fetchTicketsState: fetchTicketState);
                          showResultMessageSnackbar(
                            context: context,
                            message: "Ticket crée avec succès",
                          );
                          Navigator.of(context).pop();
                        }
                      case Error():
                        if (context.mounted) {
                          showResultMessageSnackbar(
                            context: context,
                            message: result.message,
                          );
                        }
                    }
                  } else {
                    if (context.mounted) {
                      showResultMessageSnackbar(
                        context: context,
                        message: "Vous n'avez pas sélectionner de billet",
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
