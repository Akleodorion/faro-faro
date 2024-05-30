// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:faro_faro/core/errors/failures.dart';
import 'package:faro_faro/features/members/data/models/member_model.dart';

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
