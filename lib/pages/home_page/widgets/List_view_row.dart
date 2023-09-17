import 'package:faro_clean_tdd/pages/home_page/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/events/domain/entities/event.dart';

class ListViewRow extends ConsumerWidget {
  const ListViewRow(
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
                  Text(
                    listViewTitle,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(
                      style: Theme.of(context).textButtonTheme.style,
                      onPressed: () {},
                      child: const Text(
                        "See all",
                      ))
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
