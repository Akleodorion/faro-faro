import 'package:faro_clean_tdd/features/events/presentation/widgets/event_tile/event_tile_class.dart';
import 'package:flutter/material.dart';
import '../../../domain/entities/event.dart';

class EventTile extends StatelessWidget {
  const EventTile({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    final tileClass = EventTileClass(context: context, event: event);
    return Container(
      margin: tileClass.getContainerMargin(),
      decoration: tileClass.getBoxDecoration(),
      height: tileClass.getTileHeight(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            tileClass.getImageContainer(),
            tileClass.getGeneralInfoContainer(),
            tileClass.getMoreInfoContainer(),
          ],
        ),
      ),
    );
  }
}
