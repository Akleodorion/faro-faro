import 'package:faro_clean_tdd/features/contacts/presentation/providers/contact_provider.dart';
import 'package:faro_clean_tdd/features/tickets/domain/entities/ticket.dart';
import 'package:faro_clean_tdd/features/events/presentation/pages/event_show_page/pop_page/event_management_page.dart/sections/members_section/widgets/add_member/components/modal_bottom_sheet_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SendTicket extends ConsumerWidget {
  const SendTicket({
    super.key,
    required this.mediaHeight,
    required this.ticket,
  });

  final double mediaHeight;
  final Ticket ticket;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactList = ref.read(contactsListProvider);
    return Positioned(
      top: mediaHeight * 0.05,
      right: 20,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Theme.of(context).colorScheme.background.withOpacity(0.9)),
        child: IconButton(
          onPressed: () {
            showModalBottomSheet(
                backgroundColor: Theme.of(context).colorScheme.background,
                context: context,
                builder: (BuildContext context) {
                  return ModalBottomSheetLayout(
                    mediaHeight: mediaHeight,
                    contactList: contactList,
                    ticket: ticket,
                  );
                });
          },
          icon: Icon(
            Icons.send,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
    );
  }
}
