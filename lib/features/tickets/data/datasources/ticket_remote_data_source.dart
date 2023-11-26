// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/features/tickets/data/models/ticket_model.dart';
import 'package:http/http.dart' as http;

const TICKETS_URL = "http://localhost:3001/tickets";

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
}

class TicketRemoteDataSourceImpl implements TicketRemoteDataSource {
  TicketRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<TicketModel> createTicket({required TicketModel ticket}) async {
    final uri = Uri.parse(TICKETS_URL);

    final response = await client.post(uri,
        headers: {"Content-Type": 'application/json'},
        body: json.encode(ticket.toJson()));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final TicketModel createMember =
          TicketModel.fromJson(json.decode(response.body));
      return createMember;
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      throw ServerException(
          errorMessage: json.decode(response.body)["error"][0]);
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
    final uri = Uri.parse(TICKETS_URL).replace(queryParameters: params);
    // faire la requête
    final response = await client.get(uri);
    // retour model si tout boon
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final List<dynamic> myDataMap = json.decode(response.body);

      for (var map in myDataMap) {
        myList.add(TicketModel.fromJson(map));
      }
      return myList;
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      throw ServerException(
          errorMessage: json.decode(response.body)["error"][0]);
    } else {
      throw ServerException(
          errorMessage: "An error as occured please try again later");
    }
  }

  @override
  Future<TicketModel> updateTicket(
      {required int ticketId, required int userId}) async {
    final uri = Uri.parse('$TICKETS_URL/$ticketId');
    // faire la requête
    final response = await client.patch(uri, body: {"user_id": userId});
    // retour model si tout boon
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return TicketModel.fromJson(json.decode(response.body));
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      throw ServerException(
          errorMessage: json.decode(response.body)["error"][0]);
    } else {
      throw ServerException(
          errorMessage: "An error as occured please try again later");
    }
  }
}
