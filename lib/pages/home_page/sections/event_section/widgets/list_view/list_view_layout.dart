import '../../../../../../features/events/domain/entities/event.dart';
import '../../event_card/event_card.dart';
import 'components/list_view_redirect.dart';
import 'components/list_view_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListViewLayout extends ConsumerWidget {
  const ListViewLayout(
      {super.key, required this.events, required this.listViewTitle});

  final List<Event> events;
  final String listViewTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ListViewTitle(listViewTitle: listViewTitle),
                  const ListViewRedirect()
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: events.length,
                  itemBuilder: (BuildContext context, int index) {
                    return EventCard(
                      event: events[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
