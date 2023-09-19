import 'package:faro_clean_tdd/features/events/presentation/providers/event_provider.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/state/event_state.dart';
import 'package:faro_clean_tdd/pages/search_page/sections/event_list_section/widgets/event_tile/event_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventListSection extends ConsumerWidget {
  const EventListSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventState = ref.watch(eventProvider);
    late Widget content;

    if (eventState is Loaded) {
      content = Expanded(
        child: ListView.builder(
          itemCount: eventState.indexEvent.length,
          itemBuilder: (BuildContext context, int index) {
            return EventTile(event: eventState.indexEvent[index]);
          },
        ),
      );
    }
    return content;
  }
}
