import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:flutter/material.dart';
import 'package:faro_clean_tdd/features/tickets/domain/entities/ticket.dart';

class BuyTicketCard extends StatelessWidget {
  const BuyTicketCard({
    super.key,
    required this.incrOrDecr,
    required this.event,
    required this.ticketType,
    required this.ticketQuantity,
  });

  final void Function(bool value) incrOrDecr;
  final Event event;
  final Type ticketType;
  final int ticketQuantity;

  @override
  Widget build(BuildContext context) {
    late String ticketLeft;
    late int? ticketPrice;

    if (ticketType == Type.standard) {
      ticketLeft = event.standardTicketLeft;
      ticketPrice = event.standardTicketPrice;
    } else if (ticketType == Type.gold) {
      ticketLeft = event.goldTicketLeft;
      ticketPrice = event.goldTicketPrice;
    } else {
      ticketLeft = event.platinumTicketLeft;
      ticketPrice = event.platinumTicketPrice;
    }
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ticket ${ticketType.name}:",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            ticketLeft,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(10)),
            height: 75,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ticketPrice == null
                      ? const Text("Grauit ")
                      : Text("$ticketPrice XOF"),
                  SizedBox(
                    width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            incrOrDecr(false);
                          },
                          style: IconButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              foregroundColor:
                                  Theme.of(context).colorScheme.onSecondary),
                          icon: const Icon(Icons.remove),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                          ),
                          width: 60,
                          child: Center(
                            child: Text(
                              ticketQuantity.toString(),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            incrOrDecr(true);
                          },
                          style: IconButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              foregroundColor:
                                  Theme.of(context).colorScheme.onSecondary),
                          icon: const Icon(Icons.add),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
