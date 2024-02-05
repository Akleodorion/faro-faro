import 'package:flutter/material.dart';

class EventTileGeneralInfoContainer extends StatelessWidget {
  const EventTileGeneralInfoContainer(
      {super.key,
      required this.eventTitle,
      required this.eventLimitedAddress,
      required this.eventFormatedAddress,
      required this.eventCategory});

  final String eventTitle;
  final String eventLimitedAddress;
  final String eventFormatedAddress;
  final String eventCategory;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 40) * 0.40,
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              eventTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(eventLimitedAddress,
                style: Theme.of(context).textTheme.titleSmall),
            Text(eventFormatedAddress,
                style: Theme.of(context).textTheme.titleSmall),
            Text("Category: $eventCategory",
                style: Theme.of(context).textTheme.titleSmall)
          ],
        ),
      ),
    );
  }
}
