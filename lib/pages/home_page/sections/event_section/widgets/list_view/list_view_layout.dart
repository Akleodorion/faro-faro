import '../../../../../../features/events/domain/entities/event.dart';
import '../../../../../../features/events/presentation/widgets/event_card/event_card.dart';
import 'package:flutter/material.dart';

class ListViewLayout extends StatelessWidget {
  const ListViewLayout({
    super.key,
    required this.events,
    required this.listViewTitle,
  });

  final List<Event> events;
  final String listViewTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    listViewTitle,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
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
