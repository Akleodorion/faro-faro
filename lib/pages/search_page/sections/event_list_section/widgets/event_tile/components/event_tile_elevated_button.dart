import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/pages/event_show_page/event_show_page.dart';
import 'package:flutter/material.dart';

class EventTileElevatedButton extends StatelessWidget {
  const EventTileElevatedButton({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
          return EventShowPage(
            event: event,
          );
        }));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      ),
      child: const Text(
        "Voir plus",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }
}
