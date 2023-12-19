import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/members/data/models/member_model.dart';

abstract class MemberRepository {
  // Créer un member
  Future<Either<Failure, MemberModel>> createMember(
      {required MemberModel member});

  // Supprimé un member
  Future<Failure?> deleteMember({required MemberModel member});

  // récupérer une liste de members
  Future<Either<Failure, List<MemberModel>>> fetchMembers(
      {required int userId});
}
