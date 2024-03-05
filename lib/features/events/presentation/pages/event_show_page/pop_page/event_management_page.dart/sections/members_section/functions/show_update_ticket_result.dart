import 'package:faro_clean_tdd/features/events/presentation/pages/event_show_page/pop_page/event_management_page.dart/sections/members_section/functions/show_message.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/fetch_tickets/fetch_tickets_provider.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/update_ticket/state/update_ticket_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void showUpdateTicketResult(
  BuildContext context,
  UpdateTicketState state,
  WidgetRef ref,
) {
  final bool isSucess = state is Loaded && context.mounted;
  final bool isError = state is Error && context.mounted;

  if (isSucess) {
    final fetchTicketState = ref.read(fetchTicketsProvider);
    ref.read(fetchTicketsProvider.notifier).removeTicket(
          fetchTicketsState: fetchTicketState,
          ticket: state.ticket,
        );
    showMessage(context, state.message);
    Navigator.of(context).pop();
  }

  if (isError) {
    showMessage(context, state.message);
  }
}
