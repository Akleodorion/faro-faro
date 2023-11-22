import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/members/domain/entities/member.dart';
import 'package:faro_clean_tdd/features/members/domain/repositories/member_repository.dart';

class CreateMemberUsecase {
  final MemberRepository repository;

  CreateMemberUsecase({required this.repository});

  Future<Either<Failure, Member>?> execute(
      {required int eventId, required int userId}) async {
    return await repository.createMember(eventId: eventId, userId: userId);
  }
}
