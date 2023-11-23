import 'dart:convert';

import 'package:faro_clean_tdd/features/address/domain/entities/address.dart';
import 'package:faro_clean_tdd/features/events/data/models/event_model.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:faro_clean_tdd/features/members/domain/entities/member.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  final String? apiKey = dotenv.env['API_KEY'];
  const Member tMember1 = Member(id: 1, userId: 1, eventId: 1);
  const Member tMember2 = Member(id: 1, userId: 1, eventId: 1);
  const List<Member> tMembers = [tMember1, tMember2];
  final Address address = Address(
      latitude: 42.41454,
      longitude: -127.5345,
      addressName: "Lille",
      geocodeUrl:
          "https://maps.googleapis.com/maps/api/staticmap?center=42.41454,-127.5345&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C42.41454,-127.5345&key=$apiKey");
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
    activated: false,
    standardTicketPrice: 5000,
    maxStandardTicket: 50,
    standardTicketDescription: "Standard ticket simple description",
    vipTicketPrice: 10000,
    maxVipTicket: 25,
    vipTicketDescription: "vip ticket simple description",
    vvipTicketPrice: 15000,
    maxVvipTicket: 10,
    vvipTicketDescription: "vvip ticket simple description",
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
          "standard_ticket_price": 5000,
          "max_standard_ticket": 50,
          "standard_ticket_description": "Standard ticket simple description",
          "vip_ticket_price": 10000,
          "max_vip_ticket": 25,
          "vip_ticket_description": "vip ticket simple description",
          "vvip_ticket_price": 15000,
          "max_vvip_ticket": 10,
          "vvip_ticket_description": "vvip ticket simple description",
        };

        //assert
        expect(result, tExpectedMap);
      },
    );
  });
}
