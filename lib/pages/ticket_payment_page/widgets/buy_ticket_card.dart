import 'package:flutter/material.dart';

class BuyTicketCard extends StatelessWidget {
  const BuyTicketCard(
      {super.key,
      this.ticketPrice,
      required this.ticketNumber,
      required this.ticketLeft,
      required this.ticketType,
      required this.incrOrDecr});
  final int? ticketPrice;
  final int ticketNumber;
  final String ticketType;
  final String ticketLeft;
  final void Function(bool value) incrOrDecr;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ticket $ticketType:",
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
            ticketLeft.toString(),
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
                              ticketNumber.toString(),
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
