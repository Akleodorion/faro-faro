import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/members/domain/repositories/member_repository.dart';

class DeleteMemberUsecase {
  final MemberRepository repository;

  DeleteMemberUsecase({required this.repository});

  Future<Failure?> execute({required int memberId}) async {
    return await repository.deleteMember(memberId: memberId);
  }
}
