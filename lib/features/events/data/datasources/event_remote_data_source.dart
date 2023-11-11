// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/features/events/data/models/event_model.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/event.dart';

abstract class EventRemoteDatasource {
  /// Fait une requête à http://localhost:3001/events
  ///
  /// Jette une [ServerException] en cas d'erreur
  Future<List<EventModel>> fetchAllEvents();

  // fait une requête à http://localhost:3001/event/create
  Future<EventModel?> postAnEvent({
    required String title,
    required String description,
    required DateTime date,
    required String location,
    required Category category,
    required String imageUrl,
    required int userId,
    required ModelEco modelEco,
    required int standardTicketPrice,
    required int maxStandardTicket,
    required String standardTicketDescription,
    required int vipTicketPrice,
    required int maxVipTicket,
    required String vipTicketDescription,
    required int vvipTicketPrice,
    required int maxVvipTicket,
    required String vvipTicketDescription,
  });
}

const FETCH_URL = 'http://localhost:3001/events';
const POST_EVENT_URL = 'http://localhost:3001/event/create';

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

  @override
  Future<EventModel?> postAnEvent(
      {required String title,
      required String description,
      required DateTime date,
      required String location,
      required category,
      required String imageUrl,
      required int userId,
      required modelEco,
      required int standardTicketPrice,
      required int maxStandardTicket,
      required String standardTicketDescription,
      required int vipTicketPrice,
      required int maxVipTicket,
      required String vipTicketDescription,
      required int vvipTicketPrice,
      required int maxVvipTicket,
      required String vvipTicketDescription}) async {
    // fait la requête au serveur

    return null;
  }
}
