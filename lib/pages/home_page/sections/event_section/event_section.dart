import 'package:faro_clean_tdd/pages/home_page/constants/home_page_strings.dart';
import 'package:faro_clean_tdd/pages/home_page/sections/event_section/widgets/grid_view/grid_view_layout.dart';

import '../../../../features/events/presentation/providers/fetch_event/fetch_event_provider.dart';
import 'widgets/list_view/list_view_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventSection extends ConsumerWidget {
  const EventSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget content;

    final upcomingEvents = ref.read(upcomingEventProvider);
    final randomEvents = ref.read(randomEventsProvider);
    final allEvents = ref.read(allEventProvider);

    if (allEvents.isEmpty) {
      content = const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              textAlign: TextAlign.center,
              HomePageStrings.noEventAvailable,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              HomePageStrings.addEvent,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    } else if (allEvents.length < 10) {
      content = GridViewLayout(events: allEvents);
    } else {
      content = SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListViewContainer(
              title: HomePageStrings.upcomingListViewTitle,
              events: upcomingEvents,
            ),
            const SizedBox(
              height: 10,
            ),
            ListViewContainer(
              title: HomePageStrings.randomListViewTitle,
              events: randomEvents,
            ),
          ],
        ),
      );
    }

    return Expanded(
      child: SizedBox(
        child: content,
      ),
    );
  }
}
