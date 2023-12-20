import '../../../../domain/entities/event.dart';
import 'package:flutter/material.dart';

class EventTileGeneralInfoContainer extends StatelessWidget {
  const EventTileGeneralInfoContainer({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.of(context).size.width - 40) * 0.265,
      width: (MediaQuery.of(context).size.width - 40) * 0.40,
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              event.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(event.address.getLocalityIfPresentElseReturnCountry(),
                style: Theme.of(context).textTheme.titleSmall),
            Text(event.formatedDate,
                style: Theme.of(context).textTheme.titleSmall),
            Text("Category: ${event.category.name}",
                style: Theme.of(context).textTheme.titleSmall)
          ],
        ),
      ),
    );
  }
}
