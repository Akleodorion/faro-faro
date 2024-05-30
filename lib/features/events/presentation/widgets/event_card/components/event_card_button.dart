// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:faro_faro/features/events/domain/entities/event.dart';
import 'package:faro_faro/features/events/presentation/pages/event_show_page/event_show_page.dart';
import 'package:faro_faro/features/events/presentation/widgets/constants/event_widgets_strings.dart';

class EventCardButton extends StatelessWidget {
  const EventCardButton({super.key, required this.event});
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      color: Theme.of(context).colorScheme.primary,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        splashColor: Colors.black54,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return EventShowPage(event: event);
              },
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: Text(
            EventWidgetsStrings.seeMore,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
