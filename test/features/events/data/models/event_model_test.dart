import 'dart:convert';

import 'package:faro_clean_tdd/features/events/data/models/event_model.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tEventModel = EventModel(
    name: 'Event 1',
    eventId: 1,
    description: 'short description',
    date: DateTime.tryParse('2023-09-06T10:46:37.232Z')!,
    location: 'Lille',
    category: Category.concert,
    imageUrl: 'imageUrl',
    userId: 20,
    modelEco: ModelEco.payant,
    standardTicketPrice: 5000,
    maxStandardTicket: 50,
    vipTicketPrice: 10000,
    maxVipTicket: 25,
    vvipTicketPrice: 15000,
    maxVvipTicket: 10,
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
          'category': 'concert',
          'photo_url': 'imageUrl',
          'user_id': 20,
          'free': false,
          "id": 1,
          "standard_ticket_price": 5000,
          "max_standard_ticket": 50,
          "vip_ticket_price": 10000,
          "max_vip_ticket": 25,
          "vvip_ticket_price": 15000,
          "max_vvip_ticket": 10,
        };

        //assert
        expect(result, tExpectedMap);
      },
    );
  });
}
