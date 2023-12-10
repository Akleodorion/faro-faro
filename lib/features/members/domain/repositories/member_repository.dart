import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/members/data/models/member_model.dart';
import 'package:faro_clean_tdd/features/members/domain/entities/member.dart';

abstract class MemberRepository {
  // Créer un member
  Future<Either<Failure, Member>> createMember({required MemberModel member});

  // Supprimé un member
  Future<Failure?> deleteMember({required int memberId});

  // récupérer une liste de members
  Future<Either<Failure, List<Member>>> fetchMembers({required int userId});
}
