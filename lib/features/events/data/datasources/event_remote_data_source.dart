// ignore_for_file: constant_identifier_names

// Dart imports:
import 'dart:convert';
import 'dart:io';

// Package imports:
import 'package:http/http.dart' as http;

// Project imports:
import 'package:faro_faro/core/constants/server_constants.dart';
import 'package:faro_faro/core/errors/exceptions.dart';
import 'package:faro_faro/core/util/api_call_methods.dart';
import 'package:faro_faro/features/events/data/models/event_model.dart';

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
    final response = await callIndexEventApi(ServerEventConstants.eventUrl);

    final apiCall = ApiCallMethodsImpl();
    final bool isStatusCodeOk = apiCall.isStatusCodeOK(response);
    final bool isStatusCodeBad = apiCall.isStatusCodeBad(response);

    if (isStatusCodeOk) {
      return getListOfEventsFromResponse(response);
    } else if (isStatusCodeBad) {
      throw ServerException(
        errorMessage: apiCall.extractErrorMessageFromReponse(response),
      );
    }

    throw ServerException(errorMessage: response.body);
  }

  Future<http.Response> callIndexEventApi(String url) async {
    return await client.get(
      Uri.parse(ServerEventConstants.eventUrl),
      headers: {'Accept': 'application/json'},
    );
  }

  List<EventModel> getListOfEventsFromResponse(http.Response response) {
    final List<dynamic> eventsJson =
        ApiCallMethodsImpl().extractBodyFromResponse(response, "events");
    return eventsJson.map((e) => EventModel.fromJson(e)).toList();
  }

  @override
  Future<EventModel> postAnEvent(
      {required EventModel event, required File image}) async {
    return postOrUpdateEvent(event, image, 1);
  }

  @override
  Future<EventModel> updateAnEvent(
      {required EventModel event, required File image}) async {
    return postOrUpdateEvent(event, image, 2);
  }

  Future<EventModel> postOrUpdateEvent(
      EventModel event, File image, int postOrEvent) async {
    final response = await callPostOrUpdateEvent(event, image, postOrEvent);

    final apiCall = ApiCallMethodsImpl();
    final bool isStatusCodeOk = apiCall.isStatusCodeOK(response);
    final bool isStatusCodeBad = apiCall.isStatusCodeBad(response);

    if (isStatusCodeOk) {
      final eventJson = ApiCallMethodsImpl().extractBodyFromResponse(
        response,
        "event",
      );
      return EventModel.fromJson(eventJson);
    } else if (isStatusCodeBad) {
      final message = ApiCallMethodsImpl().extractErrorMessageFromReponse(
        response,
      );
      throw ServerException(errorMessage: message);
    }

    throw ServerException(errorMessage: response.body);
  }

  Future<http.Response> callPostOrUpdateEvent(
      EventModel event, File image, int postOrEvent) async {
    if (postOrEvent == 1) {
      return await callPostEventApi(event, image);
    } else {
      return await callUpdateEventApi(event, image);
    }
  }

  Future<http.Response> callPostEventApi(EventModel event, File image) async {
    final http.MultipartRequest request =
        prepareRequest(event, image, ServerConstants.eventUrl);
    return await http.Response.fromStream(await request.send());
  }

  http.MultipartRequest prepareRequest(
    EventModel event,
    File image,
    String url,
  ) {
    final uri = Uri.parse(url);

    var request = http.MultipartRequest('POST', uri)
      ..headers['Content-Type'] = 'multipart/form-data';

    final Map<String, dynamic> myEvent = event.toJson();
    myEvent.forEach((key, value) {
      request.fields[key] = value.toString();
    });

    request.files.add(http.MultipartFile(
      'photo',
      image.readAsBytes().asStream(),
      image.lengthSync(),
      filename: 'event_image.jpg',
    ));
    return request;
  }

  Future<http.Response> callUpdateEventApi(EventModel event, File image) async {
    final request = prepareRequest(
      event,
      image,
      ServerEventConstants(eventId: event.id!).specificEndPoint(),
    );
    return await http.Response.fromStream(await request.send());
  }

  @override
  Future<EventModel> activateAnEvent({required int eventId}) async {
    return await activateOrCloseEvent(eventId: eventId, activateOrClose: 1);
  }

  @override
  Future<EventModel> closeAnEvent({required int eventId}) async {
    return await activateOrCloseEvent(eventId: eventId, activateOrClose: 2);
  }

  Future<EventModel> activateOrCloseEvent(
      {required int eventId, required int activateOrClose}) async {
    final response =
        await callActivateOrCloseEventApi(eventId, activateOrClose);

    final apiCall = ApiCallMethodsImpl();
    final bool isStatusCodeOk = apiCall.isStatusCodeOK(response);
    final bool isStatusCodeBad = apiCall.isStatusCodeBad(response);

    if (isStatusCodeOk) {
      final eventJson = apiCall.extractBodyFromResponse(response, "event");
      return EventModel.fromJson(eventJson["event"]);
    } else if (isStatusCodeBad) {
      final String message = apiCall.extractErrorMessageFromReponse(response);
      throw ServerException(errorMessage: message);
    }

    throw ServerException(
        errorMessage: "Une erreure s'est produite veuillez essayer plus tard");
  }

  Future<http.Response> callActivateOrCloseEventApi(
      int eventId, int eventOrClose) async {
    if (eventOrClose == 1) {
      return callActivateEventApi(eventId);
    } else {
      return callCloseEventApi(eventId);
    }
  }

  Future<http.Response> callActivateEventApi(int eventId) async {
    final params = {"activated": true};

    final uri = Uri.parse(
      ServerEventConstants(eventId: eventId).activateEventUrl,
    );

    return await client.put(
      uri,
      headers: {"Content-Type": 'application/json'},
      body: json.encode(params),
    );
  }

  Future<http.Response> callCloseEventApi(int eventId) async {
    final params = {"closed": true};

    final uri = Uri.parse(ServerEventConstants(eventId: eventId).closeEventUrl);

    return await client.put(uri,
        headers: {"Content-Type": 'application/json'},
        body: json.encode(params));
  }
}
