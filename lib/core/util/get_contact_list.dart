import 'package:faro_clean_tdd/features/contacts/domain/entities/contact.dart';
import 'package:contacts_service/contacts_service.dart' as cs;

abstract class GetContactList {
  Future<List<Contact>?> getContacts();
}

class GetContactListImpl implements GetContactList {
  GetContactListImpl();

  @override
  Future<List<Contact>?> getContacts() async {

    
    final listOfContacts = cs.ContactsService.getContacts();
    return null;
  }
}
