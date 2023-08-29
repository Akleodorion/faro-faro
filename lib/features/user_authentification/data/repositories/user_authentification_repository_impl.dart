import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/core/network/network_info.dart';
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

  UserAuthentificationRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, UserModel?>> logUserIn(
      String email, String password) async {
    final logInInfo = {"email": email, "password": password};
    return await _getSignInOrLogIn(logInInfo, () {
      return remoteDataSource.userLogInRequest(logInInfo);
    });
  }

  @override
  Future<Either<Failure, UserModel>> signUserIn(String email, String password,
      String username, String phoneNumber) async {
    final signInInfo = {
      "email": email,
      "password": password,
      "username": username,
      "phone_number": phoneNumber
    };
    return await _getSignInOrLogIn(signInInfo, () {
      return remoteDataSource.userSignInRequest(signInInfo: signInInfo);
    });
  }

  Future<Either<Failure, UserModel>> _getSignInOrLogIn(
      Map<String, String> authInfo, _SignInOrLogIn getSignInOrLogIn) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await getSignInOrLogIn();
        return Right(response);
      } on ServerException catch (error) {
        return Left(ServerFailure(errorMessage: error.errorMessage));
      }
    } else {
      return const Left(ServerFailure(errorMessage: "no connexion"));
    }
  }

  @override
  Future<Either<Failure, User?>> autoLogIn(String email, String password) {
    // TODO: implement autoLogIn
    throw UnimplementedError();
  }
}
