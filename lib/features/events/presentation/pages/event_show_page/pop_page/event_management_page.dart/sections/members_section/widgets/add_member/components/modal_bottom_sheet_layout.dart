import 'package:faro_clean_tdd/features/contacts/domain/entities/contact.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/tickets/domain/entities/ticket.dart';
import 'package:faro_clean_tdd/features/events/presentation/pages/event_show_page/pop_page/event_management_page.dart/sections/members_section/widgets/add_member/components/contact_grid_view.dart';
import 'package:flutter/material.dart';

class ModalBottomSheetLayout extends StatelessWidget {
  const ModalBottomSheetLayout(
      {super.key,
      required this.mediaHeight,
      required this.contactList,
      this.event,
      this.ticket});

  final double mediaHeight;
  final List<Contact> contactList;
  final Event? event;
  final Ticket? ticket;

  @override
  Widget build(BuildContext context) {
    late String title;

    if (event != null) {
      title = "Ajouter un membre à l'évènement";
    } else {
      title = "Envoyez un ticket à un contact";
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              title,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text("Contact:"),
          const SizedBox(
            height: 2,
          ),
          const Divider(
            thickness: 0.5,
          ),
          ContactGridView(
            mediaHeight: mediaHeight,
            contactList: contactList,
            event: event,
            ticket: ticket,
          )
        ],
      ),
    );
  }
}
