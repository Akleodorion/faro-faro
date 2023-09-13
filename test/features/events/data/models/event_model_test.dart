import 'dart:convert';

import 'package:faro_clean_tdd/features/events/data/models/event_model.dart';
import 'package:faro_clean_tdd/features/events/domain/entities/event.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tEventModel = EventModel(
      name: 'test',
      description: 'test test',
      date: DateTime.tryParse("2023-09-06T10:46:37.232Z")!,
      location: 'Lille',
      category: Category.concert,
      imageUrl: 'imageUrl',
      userId: 20,
      modelEco: ModelEco.gratuit,
      eventId: 1);
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
          'name': 'test',
          'description': 'test test',
          'date': "2023-09-06T10:46:37.232Z",
          'location': 'Lille',
          'category': 'concert',
          'image_url': 'imageUrl',
          'user_id': 20,
          'free': true,
          "id": 1,
        };

        //assert
        expect(result, tExpectedMap);
      },
    );
  });
}
