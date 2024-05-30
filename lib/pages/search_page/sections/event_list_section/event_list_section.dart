// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/features/events/presentation/widgets/event_tile/event_tile.dart';
import 'package:faro_faro/internal_features/category_filter/category_filter_provider.dart';

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
