import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/members/domain/entities/member.dart';
import 'package:faro_clean_tdd/features/members/domain/repositories/member_repository.dart';

class FetchMembersUsecase {
  const FetchMembersUsecase({required this.repository});
  final MemberRepository repository;

  Future<Either<Failure, List<Member>>?> execute() async {
    return await repository.fetchMembers();
  }
}
