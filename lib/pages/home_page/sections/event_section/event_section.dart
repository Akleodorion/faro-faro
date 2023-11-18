import '../../../../features/events/presentation/providers/fetch_event/fetch_event_provider.dart';
import '../../../../main.dart';
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

    if (allEvents.length < 10) {
      content = Center(
        child: Text(
          "Il n'y a pas d'évènement en cours",
          style: theme.textTheme.titleLarge,
        ),
      );
    } else {
      content = SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListViewContainer(title: "Random", events: randomEvents),
            ListViewContainer(title: "Upcoming", events: upcomingEvents),
          ],
        ),
      );
    }

    return SizedBox(
      height: (MediaQuery.of(context).size.height) * 0.76,
      child: content,
    );
  }
}
