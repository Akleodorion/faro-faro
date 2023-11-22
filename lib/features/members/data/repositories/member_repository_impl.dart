import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/core/network/network_info.dart';
import 'package:faro_clean_tdd/features/members/data/datasources/member_remote_data_source.dart';
import 'package:faro_clean_tdd/features/members/domain/entities/member.dart';
import 'package:faro_clean_tdd/features/members/domain/repositories/member_repository.dart';

// Verification Internet.
// Remote repository

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
  Future<Either<Failure, Member>?> createMember(
      {required int eventId, required int userId}) async {
    if (await networkInfo.isConnected) {
      try {
        final member = await remoteDataSource.createMember(
            eventId: eventId, userId: userId);
        return Right(member);
      } on ServerException catch (failure) {
        return Left(
          ServerFailure(errorMessage: failure.errorMessage),
        );
      }
    }
    return const Left(ServerFailure(errorMessage: noInternetConnexion));
  }

  @override
  Future<Failure?> deleteMember({required int memberId}) async {
    return null;
  }

  @override
  Future<Either<Failure, List<Member>>?> fetchMembers(
      {required int userId}) async {
    return null;
  }
}
