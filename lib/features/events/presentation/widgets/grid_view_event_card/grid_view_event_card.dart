import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/presentation/widgets/grid_view_event_card/components/grid_view_event_card_layout.dart';
import 'package:flutter/material.dart';

class GridViewEventCard extends StatelessWidget {
  const GridViewEventCard({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          boxShadow: kElevationToShadow[3]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridViewEventCardLayout(
          event: event,
        ),
      ),
    );
  }
}
