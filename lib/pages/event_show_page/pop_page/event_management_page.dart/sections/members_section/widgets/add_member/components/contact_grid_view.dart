import 'package:faro_clean_tdd/core/util/show_result_message_snackbar.dart';
import 'package:faro_clean_tdd/features/contacts/domain/entities/contact.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/members/presentation/providers/create_member/create_member_provider.dart';
import 'package:faro_clean_tdd/features/members/presentation/providers/create_member/state/create_member_state.dart';
import 'package:faro_clean_tdd/features/tickets/domain/entities/ticket.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/fetch_tickets/fetch_tickets_provider.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/update_ticket/state/update_ticket_state.dart'
    as ut;
import 'package:faro_clean_tdd/features/tickets/presentation/providers/update_ticket/update_ticket_provider.dart';
import 'package:faro_clean_tdd/pages/event_show_page/pop_page/event_management_page.dart/sections/members_section/widgets/add_member/components/contact_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactGridView extends ConsumerWidget {
  const ContactGridView(
      {super.key,
      required this.mediaHeight,
      required this.contactList,
      required this.event,
      required this.ticket});

  final double mediaHeight;
  final List<Contact> contactList;
  final Event? event;
  final Ticket? ticket;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void showMessage(BuildContext context, String message) {
      if (context.mounted) {
        showResultMessageSnackbar(context: context, message: message);
        Navigator.of(context).pop();
      }
    }

    void showResultUpdateTicket(
      BuildContext context,
      ut.UpdateTicketState state,
    ) {
      switch (state) {
        case ut.Loaded():
          final fetchState = ref.read(fetchTicketsProvider);
          ref
              .read(fetchTicketsProvider.notifier)
              .removeTicket(providedState: fetchState, ticket: state.ticket);
          showMessage(context, state.message);
          break;
        case ut.Error():
          showMessage(context, state.message);
          break;
      }
    }

    void showResultCreateMember(
      BuildContext context,
      CreateMemberState state,
    ) {
      switch (state) {
        case Loaded():
          showMessage(context, state.message);
          Navigator.of(context).pop();
          break;
        case Error():
          if (context.mounted) {
            showMessage(context, state.message);
            Navigator.of(context).pop();
          }
          break;
      }
    }

    final bool isForAddMember = event != null;
    return SizedBox(
      height: mediaHeight * 0.2,
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 3 / 2,
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        children: [
          for (final contact in contactList)
            Consumer(
              builder: (
                BuildContext context,
                WidgetRef ref,
                Widget? child,
              ) {
                return ContactCard(
                  contact: contact,
                  isForAddMember: isForAddMember,
                  onTap: () async {
                    if (isForAddMember) {
                      final stateResult = await ref
                          .read(createMemberProvider.notifier)
                          .createMember(
                              eventId: event!.eventId, userId: contact.userId);
                      if (context.mounted) {
                        showResultCreateMember(context, stateResult);
                      }
                    } else {
                      final stateResult = await ref
                          .read(updateTicketProvider.notifier)
                          .updateTicket(
                            ticketId: ticket!.id,
                            userId: contact.userId,
                          );
                      if (context.mounted) {
                        showResultUpdateTicket(context, stateResult);
                      }
                    }
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}
