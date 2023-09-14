import 'package:faro_clean_tdd/pages/home_page/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/events/domain/entities/event.dart';

class RandomRow extends ConsumerWidget {
  const RandomRow({super.key, required this.events});

  final List<Event> events;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Row(
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
                      "Random",
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
      ),
    );
  }
}
