// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:faro_faro/features/contacts/data/models/contact_model.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  group(
    "fromJson",
    () {
      const tContact = ContactModel(
          userId: 1, phoneNumber: "+2251020304050", username: "user 1");
      test(
        "should return valid Model",
        () async {
          //arrange
          final Map<String, dynamic> jsonMap =
              json.decode(fixture('contact.json'));
          //act
          final ContactModel result = ContactModel.fromJson(jsonMap);
          //assert
          expect(result, tContact);
        },
      );
    },
  );
}
