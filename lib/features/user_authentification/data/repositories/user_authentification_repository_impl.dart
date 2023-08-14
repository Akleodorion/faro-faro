import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/core/network/network_info.dart';
import 'package:faro_clean_tdd/features/user_authentification/data/datasources/user_local_data_source.dart';
import 'package:faro_clean_tdd/features/user_authentification/data/datasources/user_remote_data_source.dart';
import 'package:faro_clean_tdd/features/user_authentification/data/models/user_model.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/repositories/user_authentification_repository.dart';

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
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource
            .userLogInRequest({"email": email, "password": password});
        return Right(result!);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel?>> signUserIn(String email, String password,
      String username, String phoneNumber) async {
    return const Right(null);
  }
}
