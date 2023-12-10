import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/members/data/models/member_model.dart';
import 'package:faro_clean_tdd/features/members/domain/entities/member.dart';
import 'package:faro_clean_tdd/features/members/domain/repositories/member_repository.dart';

class CreateMemberUsecase {
  final MemberRepository repository;

  CreateMemberUsecase({required this.repository});

  Future<Either<Failure, Member>> execute({required MemberModel member}) async {
    return await repository.createMember(member: member);
  }
}
