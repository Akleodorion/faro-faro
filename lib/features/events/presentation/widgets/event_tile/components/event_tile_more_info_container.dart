import '../../../../domain/entities/event.dart';
import 'package:flutter/material.dart';

import 'event_tile_elevated_button.dart';

class EventTileMoreInfoContainer extends StatelessWidget {
  const EventTileMoreInfoContainer({super.key, required this.event});
  final Event event;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 40) * 0.25,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "A partir de :",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                event.modelEco == ModelEco.gratuit
                    ? "Gratuit"
                    : "${event.standardTicketPrice} XOF",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          EventTileElevatedButton(
            event: event,
          )
        ],
      ),
    );
  }
}
