import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/core/network/network_info.dart';
import 'package:faro_clean_tdd/core/util/datetime_comparator.dart';
import 'package:faro_clean_tdd/features/user_authentification/data/datasources/user_local_data_source.dart';
import 'package:faro_clean_tdd/features/user_authentification/data/datasources/user_remote_data_source.dart';
import 'package:faro_clean_tdd/features/user_authentification/data/models/user_model.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/entities/user.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/repositories/user_authentification_repository.dart';

typedef _SignInOrLogIn = Future<UserModel> Function();

class UserAuthentificationRepositoryImpl
    implements UserAuthentificationRepository {
  final UserLocalDataSource localDataSource;
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final DateTimeComparator dateTimeComparator;

  UserAuthentificationRepositoryImpl(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.networkInfo,
      required this.dateTimeComparator});
  @override
  Future<Either<Failure, UserModel?>> logUserIn(
      String email, String password, bool pref) async {
    final logInInfo = {
      "email": email,
      "password": password,
      "pref": pref.toString()
    };
    return await _getSignInOrLogIn(logInInfo, () {
      return remoteDataSource.userLogInRequest(logInInfo);
    });
  }

  @override
  Future<Either<Failure, UserModel>> signUserIn(String email, String password,
      String username, String phoneNumber, bool pref) async {
    final signInInfo = {
      "email": email,
      "password": password,
      "username": username,
      "phone_number": phoneNumber,
      "pref": pref.toString(),
    };
    return await _getSignInOrLogIn(signInInfo, () {
      return remoteDataSource.userSignInRequest(signInInfo: signInInfo);
    });
  }

  Future<Either<Failure, UserModel>> _getSignInOrLogIn(
      Map<String, String> authInfo, _SignInOrLogIn getSignInOrLogIn) async {
    final userAuth = {
      "email": authInfo["email"]!,
      "password": authInfo["password"]!
    };
    if (await networkInfo.isConnected) {
      try {
        final response = await getSignInOrLogIn();
        localDataSource.storeConnexionData(
            pref: authInfo["pref"] == "true" ? true : false,
            userAuth: userAuth,
            dateTime: DateTime.now().toString(),
            jwtToken: response.jwtToken);
        return Right(response);
      } on ServerException catch (error) {
        return Left(ServerFailure(errorMessage: error.errorMessage));
      }
    } else {
      return const Left(ServerFailure(errorMessage: "no connexion"));
    }
  }

  @override
  Future<Map<String, dynamic>?> getUserInfo() async {
    final lastPref = await localDataSource.getLastPref();
    final cachedToken = await localDataSource.getLastCachedToken();
    final lastLoginDateTime = await localDataSource.getLastLoginDatetime();
    final lastUserAuth = await localDataSource.getUserAuth();

    final userInfo = {
      "email": lastUserAuth!["email"],
      "password": lastUserAuth["password"],
      "token": cachedToken,
      "datetime": lastLoginDateTime,
      "pref": lastPref,
    };

    return userInfo;
  }

  @override
  Future<User?> logInWithToken() async {
    final cachedToken = await localDataSource.getLastCachedToken();
    final lastLoginDateTime = await localDataSource.getLastLoginDatetime();
    if (cachedToken!.isNotEmpty &&
        dateTimeComparator.isValid(lastLoginDateTime!)) {
      return remoteDataSource.userLogInWithToken(cachedToken);
    } else {
      return null;
    }
  }
}
