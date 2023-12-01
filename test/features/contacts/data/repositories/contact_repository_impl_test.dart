import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/core/network/network_info.dart';
import 'package:faro_clean_tdd/core/util/get_contact_list.dart';
import 'package:faro_clean_tdd/features/contacts/data/datasources/contact_remote_data_source.dart';
import 'package:faro_clean_tdd/features/contacts/data/repositories/contact_repository_impl.dart';
import 'package:faro_clean_tdd/features/contacts/domain/entities/contact.dart';
import 'package:faro_clean_tdd/features/members/data/repositories/member_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'contact_repository_impl_test.mocks.dart';

@GenerateMocks([NetworkInfo, ContactRemoteDataSource, GetContactList])
void main() {
  late MockNetworkInfo mockNetworkInfo;
  late MockContactRemoteDataSource mockContactRemoteDataSource;
  late MockGetContactList mockGetContactList;
  late ContactRepositoryImpl sut;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockContactRemoteDataSource = MockContactRemoteDataSource();
    mockGetContactList = MockGetContactList();
    sut = ContactRepositoryImpl(
        networkInfo: mockNetworkInfo,
        remoteDataSource: mockContactRemoteDataSource,
        contactList: mockGetContactList);
  });

  group(
    "fectchConctacts",
    () {
      const tNumbersList = ["+2254546585", "+22552525252"];
      const tContact1 =
          Contact(userId: 1, phoneNumber: "+2254546585", username: "user1");
      const tContact2 =
          Contact(userId: 2, phoneNumber: "+2254546585", username: "user2");
      const tContacts = [tContact1, tContact2];

      group(
        "if there is no connexion ",
        () {
          setUp(() => when(mockNetworkInfo.isConnected)
              .thenAnswer((realInvocation) async => false));
          test(
            " should return return  a ServerFailure",
            () async {
              final result = await sut.fectchConctacts();
              //assert
              expect(result,
                  const Left(ServerFailure(errorMessage: noInternetConnexion)));
              verify(mockNetworkInfo.isConnected).called(1);
            },
          );
        },
      );

      group(
        "if there is an internet connexion.",
        () {
          setUp(() => when(mockNetworkInfo.isConnected)
              .thenAnswer((realInvocation) async => true));
          group(
            "when the request of contact list is denied",
            () {
              test(
                "should return a ServerFailure",
                () async {
                  //arrange
                  when(mockGetContactList.getContacts()).thenThrow(
                      ServerException(errorMessage: 'permission requise'));
                  //act
                  final result = await sut.fectchConctacts();
                  //assert
                  expect(
                      result,
                      const Left(
                          ServerFailure(errorMessage: 'permission requise')));
                  verify(mockGetContactList.getContacts()).called(1);
                },
              );
            },
          );

          group(
            "when the request of contact list is granted",
            () {
              setUp(() => when(mockGetContactList.getContacts())
                  .thenAnswer((realInvocation) async => tNumbersList));
              test(
                "should return a valid list of contacts when the call is succesfull",
                () async {
                  //arrange
                  when(mockContactRemoteDataSource.fetchContacts(
                          numbersList: anyNamed('numbersList')))
                      .thenAnswer((realInvocation) async => tContacts);
                  //act
                  final result = await sut.fectchConctacts();
                  //assert
                  expect(result, const Right(tContacts));
                  verify(mockContactRemoteDataSource.fetchContacts(
                          numbersList: tNumbersList))
                      .called(1);
                },
              );

              test(
                "should return a ServerFailure when the call is unsuccesfull",
                () async {
                  //arrange
                  when(mockContactRemoteDataSource.fetchContacts(
                          numbersList: anyNamed('numbersList')))
                      .thenThrow(ServerException(errorMessage: 'oops'));
                  //act
                  final result = await sut.fectchConctacts();
                  //assert
                  expect(
                      result, const Left(ServerFailure(errorMessage: 'oops')));
                  verify(mockContactRemoteDataSource.fetchContacts(
                          numbersList: tNumbersList))
                      .called(1);
                },
              );
            },
          );
        },
      );
    },
  );
}
