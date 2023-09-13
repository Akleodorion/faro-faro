// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/features/events/data/models/event_model.dart';
import 'package:http/http.dart' as http;

abstract class EventRemoteDatasource {
  /// Fait une requête à http://localhost:3001/events
  ///
  /// Jete une [ServerException] en cas d'erreur
  Future<List<EventModel>> fetchAllEvents();
}

const FETCH_URL = 'http://localhost:3001/events';

class EventRemoteDatasourceImpl implements EventRemoteDatasource {
  const EventRemoteDatasourceImpl({required this.client});

  final http.Client client;

  @override
  Future<List<EventModel>> fetchAllEvents() async {
    // initialisation des variables
    List<EventModel> events = [];
    final uri = Uri.parse(FETCH_URL);

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> array = json.decode(response.body);
      for (var element in array) {
        events.add(EventModel.fromJson(element));
      }
      return events;
    } else {
      // Si la requête est infructueuse
      throw ServerException(errorMessage: response.body);
    }
  }
}
