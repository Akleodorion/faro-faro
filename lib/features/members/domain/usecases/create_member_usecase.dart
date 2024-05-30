// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/features/members/data/models/member_model.dart';
import 'package:faro_faro/features/members/domain/repositories/member_repository.dart';

class CreateMemberUsecase {
  final MemberRepository repository;

  CreateMemberUsecase({required this.repository});

  Future<Either<Failure, MemberModel>> execute(
      {required MemberModel member}) async {
    return await repository.createMember(member: member);
  }
}
