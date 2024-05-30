// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:faro_faro/core/errors/exceptions.dart';
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/core/network/network_info.dart';
import 'package:faro_faro/features/contacts/data/datasources/contact_remote_data_source.dart';
import 'package:faro_faro/features/contacts/data/repositories/contact_repository_impl.dart';
import 'package:faro_faro/features/contacts/domain/entities/contact.dart';
import 'package:faro_faro/features/members/data/repositories/member_repository_impl.dart';
import 'package:faro_faro/internal_features/contact_list/contact_list.dart';
import 'contact_repository_impl_test.mocks.dart';

@GenerateMocks([
  NetworkInfo,
  ContactRemoteDataSource,
  ContactList,
  BuildContext,
])
void main() {
  late MockNetworkInfo mockNetworkInfo;
  late MockContactRemoteDataSource mockContactRemoteDataSource;
  late MockContactList mockContactList;
  late ContactRepositoryImpl sut;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockContactRemoteDataSource = MockContactRemoteDataSource();
    mockContactList = MockContactList();
    sut = ContactRepositoryImpl(
        networkInfo: mockNetworkInfo,
        remoteDataSource: mockContactRemoteDataSource,
        contactList: mockContactList);
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
              final result = await sut.fectchConctacts(numbers: tNumbersList);
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
                  when(mockContactRemoteDataSource.fetchContactsInBatches(
                          numbersList: anyNamed("numbersList")))
                      .thenThrow(
                          ServerException(errorMessage: 'permission requise'));
                  //act
                  final result =
                      await sut.fectchConctacts(numbers: tNumbersList);
                  //assert
                  expect(
                    result,
                    const Left(
                      ServerFailure(errorMessage: 'permission requise'),
                    ),
                  );
                },
              );
            },
          );

          group(
            "when the request is successfull ",
            () {
              test(
                "should return a Right contact List",
                () async {
                  //arrange
                  when(mockContactRemoteDataSource.fetchContactsInBatches(
                          numbersList: anyNamed("numbersList")))
                      .thenAnswer((_) async => tContacts);
                  //act
                  final result =
                      await sut.fectchConctacts(numbers: tNumbersList);
                  //assert
                  expect(result, const Right(tContacts));
                },
              );
            },
          );
        },
      );
    },
  );
}
