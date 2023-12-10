import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/members/domain/entities/member.dart';
import 'package:faro_clean_tdd/features/members/domain/repositories/member_repository.dart';

class DeleteMemberUsecase {
  final MemberRepository repository;

  DeleteMemberUsecase({required this.repository});

  Future<Failure?> execute({required Member member}) async {
    return await repository.deleteMember(member: member);
  }
}
