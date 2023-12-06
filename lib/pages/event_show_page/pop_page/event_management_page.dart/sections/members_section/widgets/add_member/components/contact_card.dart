import 'package:faro_clean_tdd/core/util/usecase_alert_dialog.dart';
import 'package:faro_clean_tdd/features/contacts/domain/entities/contact.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/members/presentation/providers/create_member/create_member_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactCard extends ConsumerWidget {
  const ContactCard({
    super.key,
    required this.contact,
    required this.event,
  });

  final Contact contact;
  final Event event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        usecaseAlertDialog(
          context: context,
          title: "Ajouter le contact",
          content:
              "Voulez-vous ajouter ${contact.username} à la liste des membres de l'évènement",
          usecase: () {
            ref
                .read(createMemberProvider.notifier)
                .createMember(eventId: event.eventId, userId: contact.userId);
            Navigator.of(context).pop();
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                contact.username,
              ),
              Text(
                contact.phoneNumber,
              )
            ],
          ),
        ),
      ),
    );
  }
}
