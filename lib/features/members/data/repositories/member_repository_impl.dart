// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:faro_faro/core/errors/exceptions.dart';
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/core/network/network_info.dart';
import 'package:faro_faro/features/members/data/datasources/member_remote_data_source.dart';
import 'package:faro_faro/features/members/data/models/member_model.dart';
import 'package:faro_faro/features/members/domain/repositories/member_repository.dart';

const String noInternetConnexion =
    'No internet connexion, please try again later.';

class MemberRepositoryImpl implements MemberRepository {
  MemberRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  final NetworkInfo networkInfo;
  final MemberRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, MemberModel>> createMember(
      {required MemberModel member}) async {
    if (await networkInfo.isConnected) {
      try {
        final resultMember =
            await remoteDataSource.createMember(member: member);
        return Right(resultMember);
      } on ServerException catch (failure) {
        return Left(
          ServerFailure(errorMessage: failure.errorMessage),
        );
      }
    }
    return const Left(ServerFailure(errorMessage: noInternetConnexion));
  }

  @override
  Future<Failure?> deleteMember({required MemberModel member}) async {
    if (await networkInfo.isConnected) {
      try {
        return await remoteDataSource.deleteMember(member: member);
      } on ServerException catch (failure) {
        return ServerFailure(errorMessage: failure.errorMessage);
      }
    }
    return const ServerFailure(errorMessage: noInternetConnexion);
  }

  @override
  Future<Either<Failure, List<MemberModel>>> fetchMembers(
      {required int userId}) async {
    if (await networkInfo.isConnected) {
      try {
        final List<MemberModel> members =
            await remoteDataSource.fetchMembers(userId: userId);
        return Right(members);
      } on ServerException catch (failure) {
        return Left(ServerFailure(errorMessage: failure.errorMessage));
      }
    }
    return const Left(ServerFailure(errorMessage: noInternetConnexion));
  }
}
