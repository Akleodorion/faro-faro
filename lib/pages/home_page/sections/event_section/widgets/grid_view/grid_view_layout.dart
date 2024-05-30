// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:faro_faro/features/events/domain/entities/event.dart';
import 'package:faro_faro/features/events/presentation/widgets/grid_view_event_card/grid_view_event_card.dart';
import 'package:faro_faro/pages/home_page/constants/home_page_strings.dart';

class GridViewLayout extends StatelessWidget {
  const GridViewLayout({super.key, required this.events});

  final List<Event> events;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: [
          const Text(HomePageStrings.minus10EventTitle),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                crossAxisCount: 2,
              ),
              children: [
                for (final event in events)
                  GridViewEventCard(
                    event: event,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
