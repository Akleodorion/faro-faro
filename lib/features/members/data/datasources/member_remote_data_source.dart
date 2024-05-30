// ignore_for_file: constant_identifier_names

// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:http/http.dart' as http;

// Project imports:
import 'package:faro_faro/core/constants/server_constants.dart';
import 'package:faro_faro/core/errors/exceptions.dart';
import 'package:faro_faro/core/util/api_call_methods.dart';
import 'package:faro_faro/features/members/data/models/member_model.dart';
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
  Future<Failure?> deleteMember({required MemberModel member});

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
    final response = await makePostRequest(member);

    if (ApiCallMethodsImpl().isStatusCodeOK(response)) {
      final memberJson =
          ApiCallMethodsImpl().extractBodyFromResponse(response, "member");
      return MemberModel.fromJson(memberJson);
    }

    if (response.statusCode == 422) {
      throw422Error(response);
    }

    throw ServerException(
        errorMessage:
            "Une erreur s'est produite veuillez réitérer l'opération.");
  }

  Future<http.Response> makePostRequest(MemberModel member) async {
    final params = member.toJson();
    final uri = Uri.parse(ServerMembersConstants.memberUrl);

    return await client.post(uri,
        headers: {
          "Content-Type": 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(params));
  }

  void throw422Error(http.Response response) {
    final map = json.decode(response.body)["errors"] as Map;
    final error = map.keys.first;
    throw ServerException(
      errorMessage: json.decode(response.body)["errors"][error][0],
    );
  }

  @override
  Future<Failure?> deleteMember({required MemberModel member}) async {
    final response = await makeDeleteRequest(member);

    if (ApiCallMethodsImpl().isStatusCodeOK(response)) {
      return null;
    }
    if (ApiCallMethodsImpl().isStatusCodeBad(response)) {
      final message =
          ApiCallMethodsImpl().extractErrorMessageFromReponse(response);
      throw ServerException(errorMessage: message);
    }

    throw ServerException(
        errorMessage: "An error as occured please try again later");
  }

  Future<http.Response> makeDeleteRequest(MemberModel member) async {
    final uri = Uri.parse(
        ServerMembersConstants(memberId: member.id!).specificEndPoint());
    return await http.delete(uri, headers: {
      'Accept': 'application/json',
    });
  }

  @override
  Future<List<MemberModel>> fetchMembers({required int userId}) async {
    final response = await makeGetRequest(userId);
    if (ApiCallMethodsImpl().isStatusCodeOK(response)) {
      return getMembersListFromJson(response);
    }
    throw ServerException(
      errorMessage:
          "Une erreur s'est produite veuillez recommencer l'opération.",
    );
  }

  Future<http.Response> makeGetRequest(int userId) async {
    final Map<String, int> params = {"user_id": userId};

    final uri = Uri.parse(ServerMembersConstants.memberUrl)
        .replace(queryParameters: params);

    return await client.get(uri, headers: {
      'Accept': 'application/json',
    });
  }

  List<MemberModel> getMembersListFromJson(http.Response response) {
    final List<dynamic> membersJsonList = json.decode(response.body);
    final List<MemberModel> members =
        membersJsonList.map((member) => MemberModel.fromJson(member)).toList();
    return members;
  }
}
