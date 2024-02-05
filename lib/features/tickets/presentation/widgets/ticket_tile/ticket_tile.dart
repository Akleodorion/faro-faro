import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/presentation/providers/fetch_event/fetch_event_provider.dart';
import 'package:faro_clean_tdd/features/tickets/domain/entities/ticket.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/pages/my_ticket_page/my_ticket_page.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/widgets/ticket_tile/ticket_tile_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TicketTile extends ConsumerWidget {
  const TicketTile({super.key, required this.ticket});
  final Ticket ticket;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Event getEvent(Ticket ticket) {
      final List<Event> events = ref.read(allEventProvider);
      return events.firstWhere((element) => element.id == ticket.eventId);
    }

    final Event event = getEvent(ticket);

    final tileClass =
        TicketTileClass(context: context, ticket: ticket, event: event);

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (builder) {
                return MyTicketPage(
                  event: event,
                  ticket: ticket,
                );
              },
            ),
          );
        },
        child: Container(
          decoration: tileClass.getBoxDecoration(),
          height: tileClass.getTileHeight(),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                tileClass.getImageContainer(event.imageUrl),
                tileClass.getGeneralInfoContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
