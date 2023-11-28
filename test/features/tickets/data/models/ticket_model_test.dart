import 'dart:convert';

import 'package:faro_clean_tdd/features/tickets/data/models/ticket_model.dart';
import 'package:faro_clean_tdd/features/tickets/domain/entities/ticket.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tTicketModel = TicketModel(
    id: 4,
    type: Type.standard,
    description:
        "Libero placeat fugiat. Neque dolorum voluptates. Autem architecto illo.",
    eventId: 36,
    price: 5000,
    userId: 2,
    verified: false,
  );
  group(
    "fromJson",
    () {
      test(
        "should ",
        () async {
          //arrange
          final Map<String, dynamic> jsonMap =
              json.decode(fixture('ticket.json'));
          //act
          final result = TicketModel.fromJson(jsonMap);
          //assert
          expect(result, tTicketModel);
        },
      );
    },
  );

  group(
    "toJson",
    () {
      test(
        "should return a valid jsonMap",
        () async {
          //arrange
          final Map<String, dynamic> expectedMap = {
            "id": 4,
            "type": "standard",
            "description":
                "Libero placeat fugiat. Neque dolorum voluptates. Autem architecto illo.",
            "event_id": 36,
            "user_id": 2,
            "verified": false,
          };
          // act
          final result = tTicketModel.toJson();
          // assert
          expect(result, expectedMap);
        },
      );
    },
  );
}
