import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/fetch_event/fetch_event_provider.dart';
import 'package:faro_clean_tdd/features/tickets/domain/entities/ticket.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/pages/my_ticket_page/my_ticket_page.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/widgets/ticket_tile/components/ticket_tile_general_info_container.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/widgets/ticket_tile/components/ticket_tile_image_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TicketTile extends ConsumerWidget {
  const TicketTile({super.key, required this.ticket});
  final Ticket ticket;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Event> events = ref.read(allEventProvider);
    final Event event =
        events.firstWhere((element) => element.id == ticket.eventId);
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
            return MyTicketPage(
              event: event,
              ticket: ticket,
            );
          }));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5),
            boxShadow: kElevationToShadow[3],
          ),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                TicketTileImageContainer(event: event),
                TicketTileGeneralInfoContainer(ticket: ticket)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
