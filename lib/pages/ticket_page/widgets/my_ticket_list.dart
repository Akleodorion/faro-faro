// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/features/tickets/presentation/providers/fetch_tickets/fetch_tickets_provider.dart';
import 'package:faro_faro/features/tickets/presentation/widgets/ticket_tile/ticket_tile.dart';
import 'package:faro_faro/pages/ticket_page/constants/ticket_page_strings.dart';

class MyTicketList extends ConsumerWidget {
  const MyTicketList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myTickets = ref.watch(userTicketsProvider);
    Widget content;

    if (myTickets.isEmpty) {
      content = const Center(
        child: Text(
          TicketPageString.noTickets,
        ),
      );
    } else {
      content = SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: ListView.builder(
          itemCount: myTickets.length,
          itemBuilder: (BuildContext context, int index) {
            return TicketTile(
              ticket: myTickets[index],
            );
          },
        ),
      );
    }

    return content;
  }
}
