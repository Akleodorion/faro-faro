import 'package:faro_clean_tdd/core/util/usecase_alert_dialog.dart';
import 'package:faro_clean_tdd/features/contacts/domain/entities/contact.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  const ContactCard(
      {super.key,
      required this.contact,
      required this.isForAddMember,
      required this.onTap});

  final Contact contact;
  final bool isForAddMember;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final String content;
    final String title;

    if (isForAddMember) {
      title = "Ajouter le contact";
      content =
          "Voulez-vous ajouter ${contact.username} à la liste des membres de l'évènement ?";
    } else {
      title = "Envoyez le ticket";
      content =
          "Voulez-vous envoyez le ticket à ${contact.username} ?.\n\nVous ne pourrez plus annuler l'opération.";
    }
    return InkWell(
      onTap: () {
        usecaseAlertDialog(
          context: context,
          title: title,
          content: content,
          usecase: () {
            onTap();
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
