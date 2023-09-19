import '../../../../features/events/presentation/providers/event_provider.dart';
import '../../../../features/events/presentation/providers/state/event_state.dart';
import 'widgets/list_view/list_view_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventSection extends ConsumerWidget {
  const EventSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventState = ref.read(eventProvider);

    return SizedBox(
      height: (MediaQuery.of(context).size.height) * 0.76,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListViewContainer(
                title: "Random",
                events: eventState is Loaded ? eventState.randomEvents : []),
            ListViewContainer(
                title: "Upcoming",
                events: eventState is Loaded ? eventState.upcomingEvents : []),
          ],
        ),
      ),
    );
  }
}
