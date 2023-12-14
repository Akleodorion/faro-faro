import 'package:faro_clean_tdd/features/contacts/domain/entities/contact.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/events/presentation/pages/event_show_page/pop_page/event_management_page.dart/sections/members_section/widgets/add_member/components/modal_bottom_sheet_layout.dart';
import 'package:flutter/material.dart';

class AddMember extends StatelessWidget {
  const AddMember({
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
    return TextButton.icon(
      label: const Text("Ajouter un membre"),
      onPressed: () {
        showModalBottomSheet(
          context: (context),
          builder: (BuildContext context) {
            return ModalBottomSheetLayout(
                mediaHeight: mediaHeight,
                contactList: contactList,
                event: event);
          },
        );
      },
      icon: const Icon(Icons.add),
    );
  }
}
