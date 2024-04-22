import 'package:contacts_service/contacts_service.dart';
import 'package:faro_clean_tdd/internal_features/contact_list/methods/filter_contact_list.dart';

abstract class ContactList {
  Future<List<String>> retrieveContacts();
}

class ContactListImpl implements ContactList {
  @override
  Future<List<String>> retrieveContacts() async {
    final contacts = await ContactsService.getContacts();
    final List<String> filteredContacts = filterContactList(
      contacts: contacts,
      digits: 10,
      prefix: 225,
    );
    return filteredContacts;
  }
}
