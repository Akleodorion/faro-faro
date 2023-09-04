import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/core/network/network_info.dart';
import 'package:faro_clean_tdd/core/util/datetime_comparator.dart';
import 'package:faro_clean_tdd/features/user_authentification/data/datasources/user_local_data_source.dart';
import 'package:faro_clean_tdd/features/user_authentification/data/datasources/user_remote_data_source.dart';
import 'package:faro_clean_tdd/features/user_authentification/data/models/user_model.dart';
import 'package:faro_clean_tdd/features/user_authentification/data/repositories/user_authentification_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import './user_authentification_repository_impl_test.mocks.dart';

@GenerateMocks([
  NetworkInfo,
  UserRemoteDataSource,
  UserLocalDataSource,
  DateTimeComparator,
])
void main() {
  late MockUserRemoteDataSource mockUserRemoteDataSource;
  late MockUserLocalDataSource mockUserLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late MockDateTimeComparator mockDateTimeComparator;
  late UserAuthentificationRepositoryImpl userAuthentificationRepositoryImpl;

  setUp(() {
    mockUserRemoteDataSource = MockUserRemoteDataSource();
    mockUserLocalDataSource = MockUserLocalDataSource();
    mockDateTimeComparator = MockDateTimeComparator();
    mockNetworkInfo = MockNetworkInfo();
    userAuthentificationRepositoryImpl = UserAuthentificationRepositoryImpl(
        dateTimeComparator: mockDateTimeComparator,
        localDataSource: mockUserLocalDataSource,
        remoteDataSource: mockUserRemoteDataSource,
        networkInfo: mockNetworkInfo);
  });

  group(
    "logUserIn",
    () {
      const tEmail = "test@gmail.com";
      const tPassword = "123456";
      const tToken = "this is a token";
      const tPref = true;
      const tLogInfo = {"email": tEmail, "password": tPassword};
      const tUserModel = UserModel(
          email: tEmail,
          username: "username",
          id: 9,
          jwtToken: tToken,
          phoneNumber: "06 06 06 06 06");

      group(
        "When there is no connexion",
        () {
          test(
            "should return a serverException when there is no internet connexion",
            () async {
              //assert
              when(mockNetworkInfo.isConnected)
                  .thenAnswer((realInvocation) async => false);
              //act
              final result = await userAuthentificationRepositoryImpl.logUserIn(
                  tEmail, tPassword, tPref);
              //arrange
              expect(
                  result,
                  equals(
                      const Left(ServerFailure(errorMessage: 'no connexion'))));
            },
          );
        },
      );

      group(
        "when there is a connexion",
        () {
          setUp(() {
            when(mockNetworkInfo.isConnected)
                .thenAnswer((realInvocation) async => true);
          });
          test(
            "should return a valid userModel when the request is successful",
            () async {
              //assert
              when(mockUserRemoteDataSource.userLogInRequest(any))
                  .thenAnswer((_) async => tUserModel);
              //act
              final result = await userAuthentificationRepositoryImpl.logUserIn(
                  tEmail, tPassword, tPref);
              //arrange
              verify(mockUserRemoteDataSource.userLogInRequest(tLogInfo));

              expect(result, const Right(tUserModel));
            },
          );

          test(
            "should return a ServerFailure when the request is unsuccessful",
            () async {
              //assert
              when(mockUserRemoteDataSource.userLogInRequest(any))
                  .thenThrow(ServerException(errorMessage: 'oops'));
              //act
              final result = await userAuthentificationRepositoryImpl.logUserIn(
                  tEmail, tPassword, tPref);
              //arrange

              expect(result, const Left(ServerFailure(errorMessage: 'oops')));
            },
          );
        },
      );
    },
  );

  group(
    "signUserIn",
    () {
      const tEmail = "test@gmail.com";
      const tPassword = "123456";
      const tUsername = "username";
      const tPhoneNumber = "06 06 06 06 06";
      const tToken = "this is a token";
      const tPref = true;
      final tSignInInfo = {
        "email": tEmail,
        "password": tPassword,
        "username": tUsername,
        "phone_number": tPhoneNumber,
        "pref": tPref.toString()
      };
      const tUserModel = UserModel(
          email: tEmail,
          username: tUsername,
          id: 9,
          phoneNumber: tPhoneNumber,
          jwtToken: tToken);

      group(
        "when the internet connexion is present",
        () {
          setUp(() => when(mockNetworkInfo.isConnected)
              .thenAnswer((realInvocation) async => true));

          test(
            "should return a valid user model if the request is successful",
            () async {
              //assert
              when(mockUserRemoteDataSource.userSignInRequest(
                      signInInfo: anyNamed('signInInfo')))
                  .thenAnswer((_) async => tUserModel);
              //act
              final result =
                  await userAuthentificationRepositoryImpl.signUserIn(
                      tEmail, tPassword, tUsername, tPhoneNumber, tPref);
              //arrange
              verify(mockUserRemoteDataSource.userSignInRequest(
                  signInInfo: tSignInInfo));
              expect(result, const Right(tUserModel));
            },
          );

          test(
            "should should return a ServerFailure if the request is unsuccessful",
            () async {
              //assert
              when(mockUserRemoteDataSource.userSignInRequest(
                      signInInfo: anyNamed('signInInfo')))
                  .thenThrow(ServerException(errorMessage: 'oops'));
              //act
              final result =
                  await userAuthentificationRepositoryImpl.signUserIn(
                      tEmail, tPassword, tUsername, tPhoneNumber, tPref);
              //arrange
              verify(mockUserRemoteDataSource.userSignInRequest(
                  signInInfo: tSignInInfo));
              expect(result, const Left(ServerFailure(errorMessage: 'oops')));
            },
          );
        },
      );

      group(
        "when there is no internet connexion",
        () {
          setUp(() => when(mockNetworkInfo.isConnected)
              .thenAnswer((realInvocation) async => false));

          test(
            "should return Server Failure",
            () async {
              //act
              final result =
                  await userAuthentificationRepositoryImpl.signUserIn(
                      tEmail, tPassword, tUsername, tPhoneNumber, tPref);
              //arrange
              expect(result,
                  const Left(ServerFailure(errorMessage: 'no connexion')));
            },
          );
        },
      );
    },
  );

  group(
    "getUserInfo",
    () {
      final tDatetime = DateTime.now();
      const tToken =
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJkZWYyMGYwZC02OGY5LTQ5OTAtYjk4MC';

      group(
        "when the pref is set to true",
        () {
          const tCachedUserAuth = {
            "email": "chris@gmail.com",
            "password": "123456"
          };
          final tUserInfo = {
            "email": "chris@gmail.com",
            "password": "123456",
            "token": tToken,
            "datetime": tDatetime,
            "pref": true,
          };
          test(
            "should retrieve all the last cached data and return it has a map ",
            () async {
              //arrange
              when(mockUserLocalDataSource.getUserAuth())
                  .thenAnswer((_) async => tCachedUserAuth);
              when(mockUserLocalDataSource.getLastCachedToken())
                  .thenAnswer((_) async => tToken);
              when(mockUserLocalDataSource.getLastPref())
                  .thenAnswer((_) async => true);
              when(mockUserLocalDataSource.getLastLoginDatetime())
                  .thenAnswer((_) async => tDatetime);
              //act
              final result =
                  await userAuthentificationRepositoryImpl.getUserInfo();
              //assert
              verify(mockUserLocalDataSource.getUserAuth()).called(1);
              verify(mockUserLocalDataSource.getLastCachedToken()).called(1);
              verify(mockUserLocalDataSource.getLastPref()).called(1);
              verify(mockUserLocalDataSource.getLastLoginDatetime()).called(1);
              expect(result, tUserInfo);
            },
          );
        },
      );

      group(
        "when the pref is set to false",
        () {
          const tCachedUserAuth = {"email": "", "password": ""};
          final tUserInfo = {
            "email": "",
            "password": "",
            "token": "",
            "datetime": null,
            "pref": false,
          };

          test(
            "should retrieve all the last cached data and return it has a map ",
            () async {
              //arrange
              when(mockUserLocalDataSource.getUserAuth())
                  .thenAnswer((_) async => tCachedUserAuth);
              when(mockUserLocalDataSource.getLastCachedToken())
                  .thenAnswer((_) async => "");
              when(mockUserLocalDataSource.getLastPref())
                  .thenAnswer((_) async => false);
              when(mockUserLocalDataSource.getLastLoginDatetime())
                  .thenAnswer((_) async => null);
              //act
              final result =
                  await userAuthentificationRepositoryImpl.getUserInfo();
              //assert
              verify(mockUserLocalDataSource.getUserAuth()).called(1);
              verify(mockUserLocalDataSource.getLastCachedToken()).called(1);
              verify(mockUserLocalDataSource.getLastPref()).called(1);
              verify(mockUserLocalDataSource.getLastLoginDatetime()).called(1);
              expect(result, tUserInfo);
            },
          );
        },
      );
    },
  );
}
