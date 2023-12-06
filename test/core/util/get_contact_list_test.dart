import 'package:contacts_service/contacts_service.dart';
import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/core/util/contact_service.dart';
import 'package:faro_clean_tdd/core/util/get_contact_list.dart';
import 'package:faro_clean_tdd/core/util/permission_requester.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:permission_handler/permission_handler.dart';

import 'get_contact_list_test.mocks.dart';

@GenerateMocks([PermissionRequester, ContactService])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockPermissionRequester mockPermissionRequester;
  late MockContactService mockContactService;
  late GetContactListImpl sut;

  setUp(() {
    mockPermissionRequester = MockPermissionRequester();
    mockContactService = MockContactService();
    sut = GetContactListImpl(
        permissionRequester: mockPermissionRequester,
        contactService: mockContactService);
  });

  group(
    "getContacts",
    () {
      group(
        "when the permission has not been granted",
        () {
          test(
            "should throw a serverexception",
            () async {
              //arrange
              when(mockPermissionRequester.requestContactPermission())
                  .thenAnswer(
                      (realInvocation) async => PermissionStatus.denied);
              //act
              //assert

              expect(
                () => sut.getContacts(),
                throwsA(isA<ServerException>()),
              );
            },
          );
        },
      );

      group(
        "when the permission has been granted",
        () {
          final List<Contact> tContactNumber = [
            Contact(phones: [
              Item(label: "chris", value: "+225 10 20 30 40 50"),
              Item(label: "chris-whatsapp", value: "+225 52 52 52 52 52")
            ]),
            Contact(phones: [
              Item(label: "tressy", value: "+225 50 60 70 80 90"),
            ]),
          ];

          test(
            "should return an empty string if no number was found",
            () async {
              //arrange
              when(mockPermissionRequester.requestContactPermission())
                  .thenAnswer(
                      (realInvocation) async => PermissionStatus.granted);
              when(mockContactService.callContactService())
                  .thenAnswer((realInvocation) async => []);
              //act
              final result = await sut.getContacts();
              //assert
              expect(result, []);
            },
          );

          test(
            "should return the full list of phone number",
            () async {
              //arrange
              when(mockPermissionRequester.requestContactPermission())
                  .thenAnswer(
                      (realInvocation) async => PermissionStatus.granted);
              when(mockContactService.callContactService())
                  .thenAnswer((realInvocation) async => tContactNumber);
              //act
              final result = await sut.getContacts();
              //assert
              expect(result,
                  ["+2251020304050", "+2255252525252", "+2255060708090"]);
            },
          );
        },
      );
    },
  );
}
