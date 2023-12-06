import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:flutter/material.dart';

class TicketsSection extends StatelessWidget {
  const TicketsSection({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Informations tickets",
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Ticket standard:"),
            const SizedBox(
              height: 5,
            ),
            Text(
                "Vous avez vendu ${event.standardTicketNumber} ticket standard")
          ],
        ),
        if (event.modelEco == ModelEco.payant)
          const SizedBox(
            height: 10,
          ),
        if (event.modelEco == ModelEco.payant)
          if (event.goldTicketPrice != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Ticket gold:"),
                const SizedBox(
                  height: 5,
                ),
                Text("Vous avez vendu ${event.goldTicketNumber} ticket gold")
              ],
            ),
        if (event.modelEco == ModelEco.payant)
          const SizedBox(
            height: 10,
          ),
        if (event.modelEco == ModelEco.payant)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Ticket platinum:"),
              const SizedBox(
                height: 5,
              ),
              Text(
                  "Vous avez vendu ${event.platinumTicketNumber} ticket platinum")
            ],
          ),
        if (event.modelEco == ModelEco.payant)
          const SizedBox(
            height: 10,
          ),
        if (event.modelEco == ModelEco.payant)
          RichText(
              text: TextSpan(children: [
            const TextSpan(text: "L'évènement à généré"),
            TextSpan(
                text: " ${event.amountSold} XOF",
                style: const TextStyle(fontWeight: FontWeight.bold))
          ])),
      ],
    );
  }
}
