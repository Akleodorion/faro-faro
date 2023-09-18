import '../../../../../features/events/domain/entities/event.dart';
import 'package:flutter/material.dart';

class EventTileGeneralInfoContainer extends StatelessWidget {
  const EventTileGeneralInfoContainer({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.of(context).size.width - 40) * 0.265,
      width: (MediaQuery.of(context).size.width - 40) * 0.40,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            event.name,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary),
          ),
          Text(event.location,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.secondary)),
          Text(event.formatedDate,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.secondary)),
          Text("Category: ${event.category.name}",
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.secondary))
        ],
      ),
    );
  }
}
