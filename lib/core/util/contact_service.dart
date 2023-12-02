import 'package:contacts_service/contacts_service.dart';

abstract class ContactService {
  Future<List<Contact>> callContactService();
}

class ContactServiceImpl implements ContactService {
  @override
  Future<List<Contact>> callContactService() async {
    return ContactsService.getContacts();
  }
}
