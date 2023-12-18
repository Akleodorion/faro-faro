// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'dart:io';
import 'package:faro_clean_tdd/core/constants/server_constants.dart';
import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/features/events/data/models/event_model.dart';
import 'package:http/http.dart' as http;

abstract class EventRemoteDatasource {
  /// Fait une requête à http://localhost:3001/events
  ///
  /// Jette une [ServerException] en cas d'erreur
  Future<List<EventModel>> fetchAllEvents();

  // fait une requête à http://localhost:3001/event/create
  Future<EventModel> postAnEvent({
    required EventModel event,
    required File image,
  });

  /// Fait une requête à http://localhost:3001/event/:id/
  ///
  /// Jette une [ServerException] en cas d'erreur
  ///
  Future<EventModel> updateAnEvent(
      {required EventModel event, required File image});

  /// Fait une requête à http://localhost:3001/event/:id/
  ///
  /// Jette une [ServerException] en cas d'erreur
  ///
  Future<EventModel> activateAnEvent({required int eventId});

  Future<EventModel> closeAnEvent({required int eventId});
}

class EventRemoteDatasourceImpl implements EventRemoteDatasource {
  const EventRemoteDatasourceImpl({required this.client});

  final http.Client client;

  @override
  Future<List<EventModel>> fetchAllEvents() async {
    final response = await fetchEventIndex(ServerEventConstants.eventUrl);
    if (isStatusCodeOk(response)) {
      return getListOfEventsFromResponse(response);
    }
    throw ServerException(errorMessage: response.body);
  }

  Future<http.Response> fetchEventIndex(String url) async {
    return await client.get(
      Uri.parse(ServerEventConstants.eventUrl),
      headers: {'Accept': 'application/json'},
    );
  }

  bool isStatusCodeOk(http.Response response) {
    return response.statusCode == 200;
  }

  List<EventModel> getListOfEventsFromResponse(http.Response response) {
    final List<dynamic> eventsJson = json.decode(response.body);
    return eventsJson.map((e) => EventModel.fromJson(e)).toList();
  }

  @override
  Future<EventModel> postAnEvent(
      {required EventModel event, required File image}) async {
    // initialisation des variables
    final Map<String, dynamic> myEvent = event.toJson();
    final uri = Uri.parse(ServerEventConstants.eventUrl);

    var request = http.MultipartRequest('POST', uri)
      ..headers['Content-Type'] = 'multipart/form-data';

    myEvent.forEach((key, value) {
      request.fields[key] = value.toString();
    });

    request.files.add(http.MultipartFile(
      'photo',
      image.readAsBytes().asStream(),
      image.lengthSync(),
      filename: 'event_image.jpg',
    ));

    // fait la requête au serveur
    var response = await http.Response.fromStream(await request.send());
    if (response.statusCode == 201) {
      return EventModel.fromJson(json.decode(response.body)["event"]);
    } else if (response.statusCode == 422) {
      final errorList = json.decode(response.body)["errors"];
      throw ServerException(errorMessage: errorList[0]);
    } else {
      // Si la requête est infructueuse
      throw ServerException(errorMessage: response.body);
    }
  }

  @override
  Future<EventModel> updateAnEvent(
      {required EventModel event, required File image}) async {
    // initialisation des variables
    final Map<String, dynamic> myEvent = event.toJson();
    final uri =
        Uri.parse(ServerEventConstants(eventId: event.id!).specificEndPoint());

    var request = http.MultipartRequest('POST', uri)
      ..headers['Content-Type'] = 'multipart/form-data';

    myEvent.forEach((key, value) {
      request.fields[key] = value.toString();
    });

    request.files.add(http.MultipartFile(
      'photo',
      image.readAsBytes().asStream(),
      image.lengthSync(),
      filename: 'event_image.jpg',
    ));

    // fait la requête au serveur
    var response = await http.Response.fromStream(await request.send());
    if (response.statusCode == 200) {
      return EventModel.fromJson(json.decode(response.body)["event"]);
    } else if (response.statusCode == 422) {
      final errorList = json.decode(response.body)["errors"];
      throw ServerException(errorMessage: errorList[0]);
    } else {
      // Si la requête est infructueuse
      throw ServerException(errorMessage: response.body);
    }
  }

  @override
  Future<EventModel> activateAnEvent({required int eventId}) async {
    final uri =
        Uri.parse(ServerEventConstants(eventId: eventId).updateEventUrl);
    final params = {"activated": true};

    final response = await client.put(uri,
        headers: {"Content-Type": 'application/json'},
        body: json.encode(params));

    final bool isSuccess =
        response.statusCode >= 200 && response.statusCode < 300;

    if (isSuccess) {
      return EventModel.fromJson(json.decode(response.body)["event"]);
    }
    if (response.statusCode == 404) {
      throw ServerException(errorMessage: "Not found");
    }
    if (response.statusCode == 422) {
      throw ServerException(errorMessage: json.decode(response.body)["errors"]);
    }

    throw ServerException(
        errorMessage: "An error as occured. Please try again later");
  }

  @override
  Future<EventModel> closeAnEvent({required int eventId}) async {
    final uri = Uri.parse(ServerEventConstants(eventId: eventId).closeEventUrl);
    final params = {
      "closed": true,
    };

    final response = await client.put(uri,
        headers: {
          "Content-Type": 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(params));

    final bool isSuccess =
        response.statusCode >= 200 && response.statusCode < 300;

    if (isSuccess) {
      return EventModel.fromJson(json.decode(response.body)["event"]);
    }
    if (response.statusCode == 404) {
      throw ServerException(errorMessage: "Not found");
    }
    if (response.statusCode == 422) {
      throw ServerException(errorMessage: json.decode(response.body)["errors"]);
    }

    throw ServerException(
        errorMessage: "An error as occured. Please try again later");
  }

  //
}
