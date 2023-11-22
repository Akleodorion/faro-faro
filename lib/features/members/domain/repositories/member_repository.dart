import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/members/domain/entities/member.dart';

abstract class MemberRepository {
  // Créer un member
  Future<Either<Failure, Member>>? createMember();

  // Supprimé un member
  Future<Either<Failure, void>>? deleteMember();

  // récupérer une liste de members
  Future<Either<Failure, List<Member>>>? fetchMembers();
}
