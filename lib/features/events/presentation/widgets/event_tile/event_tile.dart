import 'components/event_tile_general_info_container.dart';
import 'components/event_tile_image_container.dart';
import 'components/event_tile_more_info_container.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/event.dart';

class EventTile extends StatelessWidget {
  const EventTile({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    final titleHeight = getTileHeight(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5),
          boxShadow: kElevationToShadow[3],
        ),
        height: titleHeight,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              EventTileImageContainer(event: event),
              EventTileGeneralInfoContainer(event: event),
              EventTileMoreInfoContainer(event: event),
            ],
          ),
        ),
      ),
    );
  }

  double getTileHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final bool screenHeightIsMini = screenHeight < 580;
    final bool screenHeightIsStandard =
        screenHeight >= 580 && screenHeight <= 700;
    final bool screenHeightIsLarge = screenHeight > 700;

    if (screenHeightIsMini) {
      return 80;
    }
    if (screenHeightIsStandard) {
      return 120;
    }
    if (screenHeightIsLarge) {
      return 130;
    }
    return 0;
  }
}
