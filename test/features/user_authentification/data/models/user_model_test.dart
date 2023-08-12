import 'dart:convert';

import 'package:faro_clean_tdd/features/user_authentification/data/models/user_model.dart';
import 'package:faro_clean_tdd/features/user_authentification/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tUserModel = UserModel(
      email: "test@gmail.com",
      username: "chris",
      phoneNumber: "06 06 06 06 06",
      password: "hello");

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
          final result = UserModel.fromJson(jsonMap);
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
            "password": "hello"
          };
          expect(result, expectedMap);
        },
      );
    },
  );
}
