import 'package:faro_clean_tdd/features/contacts/domain/entities/contact.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/presentation/pages/event_show_page/pop_page/event_management_page.dart/sections/members_section/functions/show_create_member_result.dart';
import 'package:faro_clean_tdd/features/events/presentation/pages/event_show_page/pop_page/event_management_page.dart/sections/members_section/functions/show_update_ticket_result.dart';
import 'package:faro_clean_tdd/features/members/data/models/member_model.dart';
import 'package:faro_clean_tdd/features/members/presentation/providers/create_member/create_member_provider.dart';
import 'package:faro_clean_tdd/features/tickets/domain/entities/ticket.dart';
import 'package:faro_clean_tdd/features/tickets/presentation/providers/update_ticket/update_ticket_provider.dart';
import 'package:faro_clean_tdd/features/events/presentation/pages/event_show_page/pop_page/event_management_page.dart/sections/members_section/widgets/add_member/components/contact_card.dart';
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
                            member: MemberModel(
                                id: null,
                                userId: contact.userId,
                                eventId: event!.id!,
                                username: contact.username),
                          );
                      if (context.mounted) {
                        showCreateMemberResult(
                          context,
                          stateResult,
                          ref,
                          event!,
                        );
                      }
                    } else {
                      final stateResult = await ref
                          .read(updateTicketProvider.notifier)
                          .updateTicket(
                            ticketId: ticket!.id!,
                            userId: contact.userId,
                          );
                      if (context.mounted) {
                        showUpdateTicketResult(
                          context,
                          stateResult,
                          ref,
                        );
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
