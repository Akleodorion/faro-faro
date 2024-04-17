// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:faro_clean_tdd/core/constants/server_constants.dart';
import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/features/tickets/data/models/ticket_model.dart';
import 'package:http/http.dart' as http;

abstract class TicketRemoteDataSource {
  /// Crée un ticket pour un évènement donnée.
  /// Fait une requête http à l'addresse http://localhost:3001/tickets
  ///
  /// En cas d'erreur jette un [ServerException]
  Future<TicketModel> createTicket({required TicketModel ticket});

  /// Modifie un ticket pour un évènement donnée (utilisé pour changé de propriétaire).
  /// Fait une requête http à l'addresse http://localhost:3001/tickets/:id
  ///
  /// En cas d'erreur jette un [ServerException]
  Future<TicketModel> updateTicket({
    required int ticketId,
    required int userId,
  });

  /// Récupère l'ensemble des tickets d'un utilisateur.
  /// Fait une requête http à l'addresse http://localhost:3001/tickets
  ///
  /// En cas d'erreur jette un [ServerException]
  Future<List<TicketModel>> fetchUserTickets({required int userId});

  /// Active un ticket si ce dernier n'est pas déjà ativée
  /// Fait une requête http à l'addresse  http://localhost:3001/tickets/:id/activate_ticket
  ///
  /// En cas d'erreur jette un [ServerException]
  Future<String> activateTicket(
      {required int userId, required TicketModel ticket});
}

class TicketRemoteDataSourceImpl implements TicketRemoteDataSource {
  TicketRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<TicketModel> createTicket({required TicketModel ticket}) async {
    final uri = Uri.parse(ServerTicketConstants.ticketUrl);

    final response = await client.post(
      uri,
      headers: {
        "Content-Type": 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode(
        ticket.toJson(),
      ),
    );

    if (response.statusCode == 201) {
      final TicketModel createMember =
          TicketModel.fromJson(json.decode(response.body)["ticket"]);
      return createMember;
    } else if (response.statusCode == 404 || response.statusCode == 400) {
      throw ServerException(errorMessage: json.decode(response.body)["error"]);
    } else if (response.statusCode == 422) {
      throw ServerException(
          errorMessage: json.decode(response.body)["errors"][0]);
    } else {
      throw ServerException(
          errorMessage: "An error as occured please try again later");
    }
  }

  @override
  Future<List<TicketModel>> fetchUserTickets({required int userId}) async {
    final List<TicketModel> myList = [];
    final Map<String, String> params = {
      "user_id": userId.toString(),
    };
    final uri = Uri.parse(ServerTicketConstants.ticketUrl)
        .replace(queryParameters: params);
    final response = await client.get(uri, headers: {
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      final List<dynamic> myDataMap = json.decode(response.body);

      for (var map in myDataMap) {
        myList.add(TicketModel.fromJson(map));
      }
      return myList;
    } else {
      throw ServerException(
          errorMessage: "An error as occured please try again later");
    }
  }

  @override
  Future<TicketModel> updateTicket(
      {required int ticketId, required int userId}) async {
    final uri = Uri.parse(
      ServerTicketConstants(ticketId: ticketId).transferTicketUrl,
    );
    final Map<String, dynamic> params = {"user_id": userId};
    // faire la requête
    final response = await client.put(
      uri,
      headers: {
        "Content-Type": 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode(params),
    );

    if (response.statusCode == 200) {
      return TicketModel.fromJson(json.decode(response.body)["ticket"]);
    } else if (response.statusCode == 404) {
      throw ServerException(errorMessage: json.decode(response.body)["error"]);
    } else if (response.statusCode == 422) {
      throw ServerException(errorMessage: json.decode(response.body)["errors"]);
    } else {
      throw ServerException(
          errorMessage: "An error as occured please try again later");
    }
  }

  @override
  Future<String> activateTicket(
      {required int userId, required TicketModel ticket}) async {
    final Uri uri = Uri.parse(
        ServerTicketConstants(ticketId: ticket.id!).validateTicketUrl);

    final Map<String, dynamic> params = {
      "user_id": userId,
      "id": ticket.id,
      "type": ticket.type.name,
      "event_id": ticket.eventId,
    };

    final response = await http.put(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: json.encode(params),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)["message"];
    }

    if (response.statusCode == 404 || response.statusCode == 422) {
      throw ServerException(errorMessage: json.decode(response.body)["error"]);
    }

    throw ServerException(
        errorMessage: "An error as occured please try again later");
  }
}
