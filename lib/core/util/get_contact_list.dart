import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/core/util/contact_service.dart';
import 'package:faro_clean_tdd/core/util/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class GetContactList {
  Future<List<String>> getContacts(BuildContext context);
}

class GetContactListImpl implements GetContactList {
  GetContactListImpl(
      {required this.contactService, required this.permissionHandler});

  final ContactService contactService;
  final PermissionHandler permissionHandler;

  @override
  Future<List<String>> getContacts(BuildContext context) async {
    PermissionStatus requestStatus =
        await permissionHandler.requestContactStatus();

    if (requestStatus == PermissionStatus.denied && context.mounted) {
      requestStatus = await permissionHandler.requestContact(context: context);
    }

    if (requestStatus != PermissionStatus.granted) {
      throw ServerException(
        errorMessage: "La permission n'a pas été accordée",
      );
    }

    final contacts = await contactService.callContactService();
    final List<String> filteredContacts = contactService.filterContactList(
      contacts: contacts,
      digits: 10,
      prefix: 225,
    );

    return filteredContacts;
  }
}
