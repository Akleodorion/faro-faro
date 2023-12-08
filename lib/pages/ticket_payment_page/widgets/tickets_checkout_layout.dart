import 'package:faro_clean_tdd/core/util/show_result_message_snackbar.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/tickets/data/models/ticket_model.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/create_ticket/create_ticket_provider.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/create_ticket/state/create_ticket_state.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/user_provider.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/widgets/usecase_elevated_button.dart';
import 'package:faro_clean_tdd/pages/ticket_payment_page/ticket_payment_page.dart';
import 'package:faro_clean_tdd/pages/ticket_payment_page/widgets/buy_ticket_card.dart';
import 'package:faro_clean_tdd/features/tickets/domain/entities/ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TicketsCheckoutLayout extends StatefulWidget {
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
  State<TicketsCheckoutLayout> createState() => _TicketsCheckoutLayoutState();
}

class _TicketsCheckoutLayoutState extends State<TicketsCheckoutLayout> {
  late int standardTicketQuantity = 0;
  late int goldTicketQuantity = 0;
  late int platinumTicketQuantity = 0;
  late int? totalAmount;

  @override
  Widget build(BuildContext context) {
    if (!widget.isFree) {
      totalAmount = 0;
      totalAmount = totalAmount! +
          standardTicketQuantity * widget.event.standardTicketPrice!;
      if (widget.isGoldTicketPresent) {
        totalAmount =
            totalAmount! + goldTicketQuantity * widget.event.goldTicketPrice!;
      }
      if (widget.isPlatinumTicketPresent) {
        totalAmount = totalAmount! +
            platinumTicketQuantity * widget.event.platinumTicketPrice!;
      }
    } else {
      totalAmount = null;
    }

    return Column(
      children: [
        BuyTicketCard(
          event: widget.event,
          ticketType: Type.standard,
          ticketQuantity: standardTicketQuantity,
          incrOrDecr: (value) {
            if (value) {
              if (widget.event.modelEco == ModelEco.gratuit) {
                standardTicketQuantity >= 1
                    ? showResultMessageSnackbar(
                        context: context,
                        message: "Les évènements gratuits sont à ticket unique")
                    : setState(() => standardTicketQuantity++);

                return;
              }
              standardTicketQuantity >= widget.event.standardTicketCountLeft
                  ? showResultMessageSnackbar(
                      context: context,
                      message: "Pas assez de ticket disponible.")
                  : setState(() => standardTicketQuantity++);
            } else {
              standardTicketQuantity <= 0
                  ? null
                  : setState(() => standardTicketQuantity--);
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
                goldTicketQuantity >= widget.event.goldTicketCountLeft!
                    ? showResultMessageSnackbar(
                        context: context,
                        message: "Pas assez de ticket disponible.")
                    : setState(() => goldTicketQuantity++);
              } else {
                goldTicketQuantity <= 0
                    ? null
                    : setState(() => goldTicketQuantity--);
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
                platinumTicketQuantity >= widget.event.platinumTicketCountLeft!
                    ? showResultMessageSnackbar(
                        context: context,
                        message: "Pas assez de ticket disponible.")
                    : setState(() => platinumTicketQuantity++);
              } else {
                platinumTicketQuantity <= 0
                    ? null
                    : setState(() => platinumTicketQuantity--);
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
                              id: 105000,
                              type: Type.standard,
                              description:
                                  widget.event.standardTicketDescription,
                              eventId: widget.event.eventId,
                              userId: ref.read(userInfoProvider)["user_id"],
                              qrCodeUrl: '',
                              price: widget.event.standardTicketPrice,
                              verified: false),
                        );
                    switch (result) {
                      case Loaded():
                        if (context.mounted) {
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
}
