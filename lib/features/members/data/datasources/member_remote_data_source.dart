// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/features/members/data/models/member_model.dart';
import 'package:faro_clean_tdd/features/members/domain/entities/member.dart';
import 'package:http/http.dart' as http;

import '../../../../core/errors/failures.dart';

const MEMBERS_URL = "http://localhost:3001/members";

abstract class MemberRemoteDataSource {
  /// Crée un member pour un évènement donnée.
  /// Fait une requête http à l'addresse http://localhost:3001/members
  ///
  /// En cas d'erreur jette un [ServerException]
  Future<Either<Failure, Member>?> createMember(
      {required int eventId, required int userId});

  /// Supprimé le member d'un évènement donnée.
  /// Fait une requête http à l'addresse http://localhost:3001/members/id
  ///
  /// En cas d'erreur jette un [ServerException]
  Future<Failure?> deleteMember({required int memberId});

  /// Fait une requête http à l'addresse http://localhost:3001/members
  ///
  /// En cas d'erreur jette un [ServerException]
  // Récupère l'ensemble des members de l'utilisateur connecté.
  Future<Either<Failure, List<Member>>?> fetchMembers({required int userId});
}

class MemberRemoteDataSourceImpl implements MemberRemoteDataSource {
  @override
  Future<Either<Failure, Member>?> createMember(
      {required int eventId, required int userId}) async {
    // initialisation des variables.
    final params = {
      "event_id": eventId,
      "user_id": userId,
    };
    final uri = Uri.parse(MEMBERS_URL);

    // Fait la requête au serveur.
    final response = await http.post(uri,
        headers: {"Content-Type": 'application/json'},
        body: json.encode(params));

    // S'il y a une réponse favorable renvoie le member en question.
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final MemberModel createMember =
          MemberModel.fromJson(json.decode(response.body));
      return Right(createMember);
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      throw ServerException(
          errorMessage: json.decode(response.body)["error"][0]);
    } else {
      throw ServerException(
          errorMessage: "An error as occured please try again later");
    }
  }

  @override
  Future<Failure?> deleteMember({required int memberId}) {
    // TODO: implement deleteMember
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Member>>?> fetchMembers({required int userId}) {
    // TODO: implement fetchMembers
    throw UnimplementedError();
  }
}