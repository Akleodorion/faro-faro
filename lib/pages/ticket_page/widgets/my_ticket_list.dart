import 'package:faro_clean_tdd/features/tickets/presentation/providers/fetch_tickets/fetch_tickets_provider.dart';
import 'package:faro_clean_tdd/pages/ticket_page/widgets/components/ticket_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyTicketList extends ConsumerWidget {
  const MyTicketList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myTickets = ref.watch(userTicketsProvider);

    Widget content;

    if (myTickets.isEmpty) {
      content = const Center(
          child: Text(
              "Vous n'avez pas de ticket !\nN'hésitez pas à en achetez un"));
    } else {
      content = SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: ListView.builder(
          itemCount: myTickets.length,
          itemBuilder: (BuildContext context, int index) {
            return TicketTile(ticket: myTickets[index]);
          },
        ),
      );
    }

    return content;
  }
}
