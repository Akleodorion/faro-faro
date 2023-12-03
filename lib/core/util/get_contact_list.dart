import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/core/util/contact_service.dart';
import 'package:faro_clean_tdd/core/util/permission_requester.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class GetContactList {
  Future<List<String>> getContacts();
}

class GetContactListImpl implements GetContactList {
  GetContactListImpl(
      {required this.contactService, required this.permissionRequester});

  final PermissionRequester permissionRequester;
  final ContactService contactService;
  @override
  Future<List<String>> getContacts() async {
    List<String> contactList = [];
    final requestStatus = await permissionRequester.requestContactPermission();
    if (requestStatus == PermissionStatus.denied) {
      throw ServerException(errorMessage: 'La permission est requise');
    }

    final listOfContacts = await contactService.callContactService();
    for (final contact in listOfContacts) {
      if (contact.phones != null) {
        for (final phone in contact.phones!) {
          phone.value != null
              ? contactList.add(phone.value!.replaceAll(' ', ''))
              : null;
        }
      }
    }

    return contactList;
  }
}
