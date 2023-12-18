// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:faro_clean_tdd/core/constants/server_constants.dart';
import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/features/members/data/models/member_model.dart';
import 'package:faro_clean_tdd/features/members/domain/entities/member.dart';
import 'package:http/http.dart' as http;

import '../../../../core/errors/failures.dart';

abstract class MemberRemoteDataSource {
  /// Crée un member pour un évènement donnée.
  /// Fait une requête http à l'addresse http://localhost:3001/members
  ///
  /// En cas d'erreur jette un [ServerException]
  Future<MemberModel> createMember({required MemberModel member});

  /// Supprimé le member d'un évènement donnée.
  /// Fait une requête http à l'addresse http://localhost:3001/members/id
  ///
  /// En cas d'erreur jette un [ServerException]
  Future<Failure?> deleteMember({required Member member});

  /// Fait une requête http à l'addresse http://localhost:3001/members
  ///
  /// En cas d'erreur jette un [ServerException]
  // Récupère l'ensemble des members de l'utilisateur connecté.
  Future<List<MemberModel>> fetchMembers({required int userId});
}

class MemberRemoteDataSourceImpl implements MemberRemoteDataSource {
  MemberRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<MemberModel> createMember({required MemberModel member}) async {
    // initialisation des variables.
    final params = member.toJson();
    final uri = Uri.parse(ServerMembersConstants.memberUrl);

    // Fait la requête au serveur.
    final response = await client.post(uri,
        headers: {
          "Content-Type": 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(params));

    if (response.statusCode == 201) {
      final MemberModel createMember =
          MemberModel.fromJson(json.decode(response.body)["member"]);
      return createMember;
    }

    if (response.statusCode == 422) {
      throw ServerException(
          errorMessage: json.decode(response.body)["errors"]["user_id"][0]);
    }

    if (response.statusCode == 404) {
      throw ServerException(errorMessage: "Not found");
    }

    throw ServerException(
        errorMessage: "An error as occured please try again later");
  }

  @override
  Future<Failure?> deleteMember({required Member member}) async {
    final uri = Uri.parse(
        ServerMembersConstants(memberId: member.id!).specificEndPoint());
    final response = await http.delete(uri, headers: {
      'Accept': 'application/json',
    });

    final isSuccess = response.statusCode >= 200 && response.statusCode < 300;

    if (isSuccess) {
      return null;
    }
    if (response.statusCode == 404) {
      throw ServerException(errorMessage: "Not found");
    }
    if (response.statusCode >= 400 && response.statusCode < 500) {
      throw ServerException(errorMessage: json.decode(response.body)["error"]);
    }
    throw ServerException(
        errorMessage: "An error as occured please try again later");
  }

  @override
  Future<List<MemberModel>> fetchMembers({required int userId}) async {
    final Map<String, int> params = {
      "user_id": userId,
    };
    final uri = Uri.parse(ServerMembersConstants.memberUrl)
        .replace(queryParameters: params);
    final response = await client.get(uri, headers: {
      'Accept': 'application/json',
    });

    final bool isRequestSuccess =
        response.statusCode >= 200 && response.statusCode < 300;

    if (isRequestSuccess) {
      late List<MemberModel> members = [];
      final List<dynamic> array = json.decode(response.body);
      for (var element in array) {
        members.add(MemberModel.fromJson(element["member"]));
      }
      return members;
    }
    throw ServerException(
        errorMessage: "An error as occured please try again later");
  }
}
