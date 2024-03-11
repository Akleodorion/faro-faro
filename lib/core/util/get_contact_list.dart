import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/core/util/contact_service.dart';
import 'package:faro_clean_tdd/core/util/permission_requester.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class GetContactList {
  Future<List<String>> getContacts(BuildContext context);
}

class GetContactListImpl implements GetContactList {
  GetContactListImpl(
      {required this.contactService, required this.permissionRequester});

  final PermissionRequester permissionRequester;
  final ContactService contactService;

  @override
  Future<List<String>> getContacts(BuildContext context) async {
    PermissionStatus requestStatus = await Permission.contacts.status;
    if (requestStatus == PermissionStatus.denied && context.mounted) {
      // Montrer le dialog
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Permission"),
              content: const Text(
                  "Cette fonctionnalité à besoin d'un accès à votre liste de contact."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Continuer"),
                )
              ],
            );
          });
      // demander la permission.
      requestStatus = await Permission.contacts.request();
    }
    if (requestStatus == PermissionStatus.granted) {
      final listOfContacts = await contactService.callContactService();
      final List<String> contacts = contactService.filterContactList(
        contacts: listOfContacts,
        digits: 10,
        prefix: 225,
      );

      return contacts;
    }
    throw ServerException(
      errorMessage: "La permission n'a pas été accordée",
    );
  }
}
