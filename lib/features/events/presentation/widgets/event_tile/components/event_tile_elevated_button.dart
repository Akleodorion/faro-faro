// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:faro_faro/features/events/domain/entities/event.dart';
import 'package:faro_faro/features/events/presentation/widgets/event_card/components/event_card_button.dart';

class EventTileElevatedButton extends StatelessWidget {
  const EventTileElevatedButton({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return EventCardButton(event: event);
  }
}
