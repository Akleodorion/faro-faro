import 'dart:convert';

import 'package:faro_clean_tdd/features/address/data/models/address_model.dart';
import 'package:faro_clean_tdd/features/address/domain/entities/address.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tAddressModel = AddressModel(
      latitude: 37.4224428,
      longitude: -122.0842467,
      addressName: "1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA");

  test(
    "should be a subclass of Address",
    () async {
      //assert

      expect(tAddressModel, isA<Address>());
    },
  );

  group('FromJson', () {
    test(
      "should return a valid  of AddressModel",
      () async {
        //act
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('address.json'));
        //assert
        final result = AddressModel.fromJson(jsonMap);
        expect(result, tAddressModel);
      },
    );
  });

  group('toJson', () {
    test(
      "should return a valid Json",
      () async {
        //act
        final result = tAddressModel.toJson();
        final tExpectedMap = {
          'latitude': 37.4224428,
          'longitude': -122.0842467,
          'addressName': "1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA"
        };
        //assert
        expect(result, equals(tExpectedMap));
      },
    );
  });
}
