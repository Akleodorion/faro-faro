import 'package:flutter/material.dart';

import '../../../../../features/events/domain/entities/event.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.event});
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
          boxShadow: kElevationToShadow[3]),
      height: 300,
      width: 210,
      margin: const EdgeInsets.only(right: 35),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // image
            Container(
              width: double.infinity,
              height: 190,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                image: DecorationImage(
                  image: NetworkImage(event.imageUrl),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              event.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              "${event.formatedDate} - ${event.address.addressName}",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "A partir de:",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      event.modelEco == ModelEco.gratuit
                          ? "Gratuit"
                          : "${event.standardTicketPrice} XOF",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    textStyle: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  ),
                  onPressed: () {},
                  child: const Text("Voir plus"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
