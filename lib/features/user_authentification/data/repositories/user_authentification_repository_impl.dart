import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/constants/error_constants.dart';
import 'package:faro_clean_tdd/core/util/date_time_util/date_time_util.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/user_local_data_source.dart';
import '../datasources/user_remote_data_source.dart';
import '../models/user_model.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_authentification_repository.dart';

typedef _SignInOrLogIn = Future<UserModel> Function();

class UserAuthentificationRepositoryImpl
    implements UserAuthentificationRepository {
  final UserLocalDataSource localDataSource;
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final DateTimeUtil dateTimeUtil;

  UserAuthentificationRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
    required this.dateTimeUtil,
  });

  @override
  Future<Either<Failure, UserModel>> logUserIn(
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
      return const Left(
        ServerFailure(errorMessage: ErrorConstants.noInternetConnexion),
      );
    }
  }

  @override
  Future<Map<String, dynamic>> getUserInfo() async {
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
    final bool isLastLoginValid =
        dateTimeUtil.isDateTimeDifferenceInMinuteValid(
            first: DateTime.now(),
            second: lastLoginDateTime ??
                DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day - 1),
            minutesTreshold: 60);
    if (cachedToken!.isNotEmpty && isLastLoginValid) {
      return remoteDataSource.userLogInWithToken(cachedToken);
    } else {
      return null;
    }
  }

  @override
  Future<Failure?> logUserOut({required String jwt}) async {
    try {
      await remoteDataSource.userLogOutRequest(jwt: jwt);
      await localDataSource.resetLastCachedTokenAndDateTime();
      return null;
    } on ServerException catch (e) {
      return ServerFailure(errorMessage: e.errorMessage);
    }
  }

  @override
  Future<Either<Failure, String>> requestResetToken(
      {required String email}) async {
    try {
      final result = await remoteDataSource.requestResetToken(email: email);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(errorMessage: error.errorMessage));
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword({
    required String email,
    required String token,
    required String newPassword,
  }) async {
    try {
      final result = await remoteDataSource.resetPassword(
          email: email, token: token, newPassword: newPassword);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(errorMessage: error.errorMessage));
    }
  }
}
