import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/fetch_event/fetch_event_provider.dart';
import 'package:faro_clean_tdd/features/tickets/domain/entities/ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TicketTileMoreInfoContainer extends ConsumerWidget {
  const TicketTileMoreInfoContainer({super.key, required this.ticket});

  final Ticket ticket;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Event> events = ref.read(allEventProvider);
    final Event event =
        events.firstWhere((element) => element.eventId == ticket.eventId);
    return SizedBox(
      height: (MediaQuery.of(context).size.width - 40) * 0.25,
      width: (MediaQuery.of(context).size.width - 40) * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            "A partir de :",
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
          ),
          Text(
            event.modelEco == ModelEco.gratuit
                ? "Gratuit"
                : "${event.standardTicketPrice} XOF",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 5,
          ),
          // EventTileElevatedButton(
          //   event: event,
          // )
        ],
      ),
    );
  }
}
