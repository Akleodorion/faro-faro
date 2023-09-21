import 'package:faro_clean_tdd/features/category_filter/presentation/providers/state/filter_notifier.dart';
import 'package:faro_clean_tdd/pages/search_page/sections/event_list_section/widgets/event_tile/event_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventListSection extends ConsumerWidget {
  const EventListSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterEventState = ref.watch(filteredEventsProvider);
    late Widget content;

    content = Expanded(
      child: ListView.builder(
        itemCount: filterEventState!.length,
        itemBuilder: (BuildContext context, int index) {
          return EventTile(event: filterEventState[index]);
        },
      ),
    );
    return content;
  }
}
