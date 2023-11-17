import 'package:faro_clean_tdd/internal_features/category_filter/category_filter_provider.dart';
import 'package:faro_clean_tdd/pages/search_page/sections/event_list_section/widgets/event_tile/event_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventListSection extends ConsumerWidget {
  const EventListSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredEventList = ref.watch(filteredEventProvider);
    Widget content;

    content = Expanded(
      child: ListView.builder(
        itemCount: filteredEventList.length,
        itemBuilder: (BuildContext context, int index) {
          return EventTile(event: filteredEventList[index]);
        },
      ),
    );
    return content;
  }
}
