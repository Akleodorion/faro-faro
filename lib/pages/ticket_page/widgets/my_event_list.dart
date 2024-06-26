// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/features/events/presentation/providers/fetch_event/fetch_event_provider.dart';
import 'package:faro_faro/features/events/presentation/widgets/event_tile/event_tile.dart';
import 'package:faro_faro/pages/ticket_page/constants/ticket_page_strings.dart';

class MyEventList extends ConsumerWidget {
  const MyEventList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myEvents = ref.read(myEventProvider);
    Widget content;

    if (myEvents.isEmpty) {
      content = const Center(
        child: Text(
          TicketPageString.noEvents,
        ),
      );
    } else {
      content = SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: ListView.builder(
          itemCount: myEvents.length,
          itemBuilder: (BuildContext context, int index) {
            return EventTile(
              event: myEvents[index],
            );
          },
        ),
      );
    }

    return content;
  }
}
