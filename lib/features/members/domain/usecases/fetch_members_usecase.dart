// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/features/members/domain/entities/member.dart';
import 'package:faro_faro/features/members/domain/repositories/member_repository.dart';

class FetchMembersUsecase {
  const FetchMembersUsecase({required this.repository});
  final MemberRepository repository;

  Future<Either<Failure, List<Member>>> execute({required int userId}) async {
    return await repository.fetchMembers(userId: userId);
  }
}
