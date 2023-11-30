import 'package:contacts_service/contacts_service.dart';
import 'package:faro_clean_tdd/core/util/get_contact_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_contact_list_test.mocks.dart';

@GenerateMocks([ContactsService])
void main() {
  late MockContactsService mockContactsService;
  late GetContactListImpl sut;

  setUp(() {
    mockContactsService = MockContactsService();
    sut = GetContactListImpl(contact: mockContactsService);
  });

  group(
    "getContacts",
    () {},
  );
}
