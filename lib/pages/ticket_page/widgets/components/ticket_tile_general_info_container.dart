import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/fetch_event/fetch_event_provider.dart';
import 'package:faro_clean_tdd/features/tickets/domain/entities/ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TicketTileGeneralInfoContainer extends ConsumerWidget {
  const TicketTileGeneralInfoContainer({super.key, required this.ticket});

  final Ticket ticket;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Event> events = ref.read(allEventProvider);
    final Event event =
        events.firstWhere((element) => element.eventId == ticket.eventId);

    return SizedBox(
      height: (MediaQuery.of(context).size.width - 40) * 0.33,
      width: (MediaQuery.of(context).size.width - 40) * 0.40,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            event.name,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary),
          ),
          Text("Type: ${ticket.type.name}",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary)),
          Text(event.address.getFormattedAddress(),
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.secondary)),
          Text(event.formatedDate,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.secondary)),
        ],
      ),
    );
  }
}
