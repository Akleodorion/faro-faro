import 'package:faro_clean_tdd/features/contacts/domain/entities/contact.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/pages/event_show_page/pop_page/event_management_page.dart/sections/members_section/widgets/add_member/components/contact_grid_view.dart';
import 'package:flutter/material.dart';

class ModalBottomSheetLayout extends StatelessWidget {
  const ModalBottomSheetLayout({
    super.key,
    required this.mediaHeight,
    required this.contactList,
    required this.event,
  });

  final double mediaHeight;
  final List<Contact> contactList;
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              "Ajouter un membre à l'évènement",
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
              mediaHeight: mediaHeight, contactList: contactList, event: event)
        ],
      ),
    );
  }
}
