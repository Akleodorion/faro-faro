import 'package:faro_clean_tdd/features/contacts/domain/entities/contact.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/pages/event_show_page/pop_page/event_management_page.dart/sections/members_section/widgets/add_member/components/contact_card.dart';
import 'package:flutter/material.dart';

class ContactGridView extends StatelessWidget {
  const ContactGridView({
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
            ContactCard(contact: contact, event: event),
        ],
      ),
    );
  }
}
