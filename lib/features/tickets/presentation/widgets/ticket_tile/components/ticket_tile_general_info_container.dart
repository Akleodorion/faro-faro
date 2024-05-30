// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/features/events/domain/entities/event.dart';
import 'package:faro_faro/features/events/presentation/providers/fetch_event/fetch_event_provider.dart';
import 'package:faro_faro/features/tickets/domain/entities/ticket.dart';

class TicketTileGeneralInfoContainer extends ConsumerWidget {
  const TicketTileGeneralInfoContainer({
    super.key,
    required this.ticket,
    required this.ticketFormatedDescription,
  });

  final Ticket ticket;
  final String ticketFormatedDescription;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Event> events = ref.read(allEventProvider);
    final Event event =
        events.firstWhere((element) => element.id == ticket.eventId);

    return SizedBox(
      width: (MediaQuery.of(context).size.width - 40) * 0.7,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              event.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              "Ticket: ${ticket.type.name}",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              ticketFormatedDescription,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
