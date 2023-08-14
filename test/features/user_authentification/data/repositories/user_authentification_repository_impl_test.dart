import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/core/network/network_info.dart';
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
])
void main() {
  late MockUserRemoteDataSource mockUserRemoteDataSource;
  late MockUserLocalDataSource mockUserLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late UserAuthentificationRepositoryImpl userAuthentificationRepositoryImpl;

  setUp(() {
    mockUserRemoteDataSource = MockUserRemoteDataSource();
    mockUserLocalDataSource = MockUserLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    userAuthentificationRepositoryImpl = UserAuthentificationRepositoryImpl(
        localDataSource: mockUserLocalDataSource,
        remoteDataSource: mockUserRemoteDataSource,
        networkInfo: mockNetworkInfo);
  });

  group(
    "logUserIn",
    () {
      const tEmail = "test@gmail.com";
      const tPassword = "123456";
      const tLogInfo = {"email": tEmail, "password": tPassword};
      const tUserModel = UserModel(
          email: tEmail,
          username: "username",
          id: 9,
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
                  tEmail, tPassword);
              //arrange
              expect(result, equals(Left(ServerFailure())));
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
                  tEmail, tPassword);
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
                  .thenThrow(ServerException());
              //act
              final result = await userAuthentificationRepositoryImpl.logUserIn(
                  tEmail, tPassword);
              //arrange

              expect(result, Left(ServerFailure()));
            },
          );
        },
      );
    },
  );
}
