import 'package:contacts_service/contacts_service.dart';
import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/core/util/contact_service.dart';
import 'package:faro_clean_tdd/core/util/get_contact_list.dart';
import 'package:faro_clean_tdd/core/util/permission_requester/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:permission_handler/permission_handler.dart';

import 'get_contact_list_test.mocks.dart';

@GenerateMocks([PermissionHandler, ContactService, BuildContext])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockPermissionHandler mockPermissionHandler;
  late MockBuildContext mockBuildContext;
  late MockContactService mockContactService;
  late GetContactListImpl sut;

  setUp(() {
    mockPermissionHandler = MockPermissionHandler();
    mockBuildContext = MockBuildContext();
    mockContactService = MockContactService();
    sut = GetContactListImpl(
        permissionHandler: mockPermissionHandler,
        contactService: mockContactService);
  });

  group(
    "getContacts",
    () {
      setUp(() {
        when(mockPermissionHandler.requestContactStatus()).thenAnswer(
          (_) async => PermissionStatus.denied,
        );
      });
      group(
        "when the permission has not been granted",
        () {
          setUp(() {
            when(mockPermissionHandler.requestContact(
                    context: anyNamed('context')))
                .thenAnswer((_) async => PermissionStatus.denied);

            when(mockBuildContext.mounted).thenReturn(true);
          });
          test("should throw a ServerException", () async {
            expect(
              () async => await sut.getContacts(mockBuildContext),
              throwsA(
                isA<ServerException>(),
              ),
            );
          });
        },
      );

      group(
        "when the permission has been granted",
        () {
          final Contact contact1 = Contact(
            givenName: "Chris",
            phones: [
              Item(value: "+225 08 07 09 02 94"),
            ],
          );
          final Contact contact2 = Contact(
            givenName: "Tressy",
            phones: [
              Item(value: "+225 08 07 26 01 93"),
            ],
          );
          final List<Contact> contacts = [contact1, contact2];
          setUp(() {
            when(
              mockPermissionHandler.requestContact(
                context: anyNamed('context'),
              ),
            ).thenAnswer((_) async => PermissionStatus.granted);
            when(mockBuildContext.mounted).thenReturn(true);
          });

          test(
            "should return a filtered list of phone number",
            () async {
              final List<String> numbers = [
                "+225 08 07 09 02 94",
                "+225 08 07 26 01 93",
              ];

              when(mockContactService.callContactService())
                  .thenAnswer((_) async => contacts);
              when(
                mockContactService.filterContactList(
                    contacts: anyNamed("contacts"),
                    digits: anyNamed("digits"),
                    prefix: anyNamed("prefix")),
              ).thenAnswer((_) => numbers);

              final result = await sut.getContacts(mockBuildContext);
              expect(result, numbers);
            },
          );
        },
      );
    },
  );
}
