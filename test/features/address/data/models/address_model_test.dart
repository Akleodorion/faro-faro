import 'dart:convert';

import 'package:faro_clean_tdd/features/address/data/models/address_model.dart';
import 'package:faro_clean_tdd/features/address/domain/entities/address.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  final apiKey = dotenv.env['API_KEY'];

  final tAddressModel = AddressModel(
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
