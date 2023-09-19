import '../../../../../../../features/events/domain/entities/event.dart';
import 'package:flutter/material.dart';

import 'event_tile_elevated_button.dart';

class EventTileMoreInfoContainer extends StatelessWidget {
  const EventTileMoreInfoContainer({super.key, required this.event});
  final Event event;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.of(context).size.width - 40) * 0.25,
      width: (MediaQuery.of(context).size.width - 40) * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            "A partir de :",
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
          ),
          Text(
            "${event.standardTicketPrice} XOF",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 5,
          ),
          const EventTileElevatedButton()
        ],
      ),
    );
  }
}
