import 'dart:convert';

import 'package:faro_clean_tdd/features/members/data/models/member_model.dart';
import 'package:faro_clean_tdd/features/members/domain/entities/member.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tMemberModel =
      MemberModel(id: 1, userId: 1, eventId: 1, username: "test");

  test(
    "should be a subclass of Member",
    () async {
      //assert
      expect(tMemberModel, isA<Member>());
    },
  );

  group(
    "fromJson",
    () {
      test(
        "should return a valid Member Model",
        () async {
          //arrange
          Map<String, dynamic> jsonMap = json.decode(fixture('member.json'));
          //act
          final result = MemberModel.fromJson(jsonMap);
          //assert
          expect(result, equals(tMemberModel));
        },
      );
    },
  );

  group(
    "toJson",
    () {
      test(
        "should return a valid jsonFile",
        () async {
          //arrange
          const expectedMap = {
            "id": 1,
            "user_id": 1,
            "event_id": 1,
            "username": "test"
          };
          //act
          final result = tMemberModel.toJson();
          //assert
          expect(result, expectedMap);
        },
      );
    },
  );
}
