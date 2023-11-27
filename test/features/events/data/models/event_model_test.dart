import 'dart:convert';

import 'package:faro_clean_tdd/features/address/domain/entities/address.dart';
import 'package:faro_clean_tdd/features/events/data/models/event_model.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/members/domain/entities/member.dart';
import 'package:faro_clean_tdd/features/tickets/domain/entities/ticket.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  final String? apiKey = dotenv.env['API_KEY'];
  const tTicket1 = Ticket(
      id: 1,
      type: Type.standard,
      description: "description",
      eventId: 1,
      userId: 1,
      verified: false);
  const tTicket2 = Ticket(
      id: 2,
      type: Type.standard,
      description: "description",
      eventId: 1,
      userId: 2,
      verified: false);
  const tTickets = [tTicket1, tTicket2];
  const Member tMember1 = Member(id: 1, userId: 1, eventId: 1);
  const Member tMember2 = Member(id: 1, userId: 1, eventId: 1);
  const List<Member> tMembers = [tMember1, tMember2];
  final Address address = Address(
      latitude: 4.7,
      longitude: -3.9,
      geocodeUrl:
          'https://maps.googleapis.com/maps/api/staticmap?center=37.4224428,-122.0842467&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C37.4224428,-122.0842467&key=$apiKey',
      country: "Côte d'Ivoire",
      countryCode: "CI",
      locality: "Abidjan",
      plusCode: "9359+HXR",
      road: "Route d'Abatta",
      sublocality: "Cocody");
  final tEventModel = EventModel(
    name: 'Event 1',
    eventId: 25,
    description: 'short description',
    date: DateTime.tryParse("2023-09-06T10:46:37.232Z")!,
    address: address,
    category: Category.concert,
    imageUrl: 'imageUrl',
    userId: 20,
    modelEco: ModelEco.payant,
    members: tMembers,
    tickets: tTickets,
    activated: false,
    standardTicketPrice: 5000,
    maxStandardTicket: 50,
    standardTicketDescription: "Standard ticket simple description",
    goldTicketPrice: 10000,
    maxGoldTicket: 25,
    goldTicketDescription: "gold ticket simple description",
    platinumTicketPrice: 15000,
    maxPlatinumTicket: 10,
    platinumTicketDescription: "platinum ticket simple description",
  );
  test(
    "should be a subsclass of Event",
    () async {
      //assert
      expect(tEventModel, isA<Event>());
    },
  );

  group(
    "FromJson",
    () {
      test(
        "should return a valid EventModel",
        () async {
          //arrange
          final Map<String, dynamic> jsonMap =
              json.decode(fixture('event.json'));
          //act
          final result = EventModel.fromJson(jsonMap);
          //assert
          expect(result, tEventModel);
        },
      );
    },
  );

  group('toJson', () {
    test(
      "should return a valid Json file",
      () async {
        //act
        final result = tEventModel.toJson();
        final tExpectedMap = {
          'name': 'Event 1',
          'description': 'short description',
          'date': "2023-09-06T10:46:37.232Z",
          'location': 'Lille',
          'latitude': 42.41454,
          'longitude': -127.5345,
          'category': 'concert',
          'photo_url': 'imageUrl',
          'user_id': 20,
          'free': false,
          "id": 25,
          "members": [
            {"id": 1, "event_id": 1, "user_id": 1},
            {"id": 1, "event_id": 1, "user_id": 1}
          ],
          'tickets': [
            {
              'id': 1,
              'type': 'standard',
              'description': 'description',
              'price': null,
              'verified': false,
              'user_id': 1,
              'event_id': 1
            },
            {
              'id': 2,
              'type': 'standard',
              'description': 'description',
              'price': null,
              'verified': false,
              'user_id': 2,
              'event_id': 1
            }
          ],
          "standard_ticket_price": 5000,
          "max_standard_ticket": 50,
          "standard_ticket_description": "Standard ticket simple description",
          "gold_ticket_price": 10000,
          "max_gold_ticket": 25,
          "gold_ticket_description": "gold ticket simple description",
          "platinum_ticket_price": 15000,
          "max_platinum_ticket": 10,
          "platinum_ticket_description": "platinum ticket simple description",
        };

        //assert
        expect(result, tExpectedMap);
      },
    );
  });
}
