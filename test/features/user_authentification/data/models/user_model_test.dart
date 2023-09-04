import 'dart:convert';

import 'package:faro_clean_tdd/features/user_authentification/data/models/user_model.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tToken = "this is a token";

  const tUserModel = UserModel(
      email: "test@gmail.com",
      username: "chris",
      phoneNumber: "06 06 06 06 06",
      jwtToken: tToken,
      id: 9);

  test(
    "should be a subclass of User",
    () async {
      //arrange
      expect(tUserModel, isA<User>());
    },
  );

  group(
    "FromJson",
    () {
      test(
        "should return a valid UserModel",
        () async {
          //assert
          final Map<String, dynamic> jsonMap =
              json.decode(fixture('user.json'));
          //act
          final result = UserModel.fromJson(jsonMap, true, tToken);
          //arrange
          expect(result, tUserModel);
        },
      );
    },
  );

  group(
    "toJson",
    () {
      test(
        "should return a valid Json File",
        () async {
          //act
          final result = tUserModel.toJson();
          //arrange
          final expectedMap = {
            'email': "test@gmail.com",
            "username": "chris",
            "phone_number": "06 06 06 06 06",
            "id": 9
          };
          expect(result, expectedMap);
        },
      );
    },
  );
}
