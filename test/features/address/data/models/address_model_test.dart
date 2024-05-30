// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:faro_faro/features/address/data/models/address_model.dart';
import 'package:faro_faro/features/address/domain/entities/address.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  final apiKey = dotenv.env['API_KEY'];

  final tAddressModel = AddressModel(
      latitude: 4.7,
      longitude: -3.9,
      geocodeUrl:
          'https://maps.googleapis.com/maps/api/staticmap?center=4.7,-3.9&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C4.7,-3.9&key=$apiKey',
      country: "Côte d'Ivoire",
      countryCode: "CI",
      locality: "Abidjan",
      plusCode: null,
      road: "Route d'Abatta",
      sublocality: null);
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
          "country": "Côte d'Ivoire",
          "country_code": "CI",
          "locality": "Abidjan",
          "geocode_url":
              'https://maps.googleapis.com/maps/api/staticmap?center=4.7,-3.9&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C4.7,-3.9&key=$apiKey',
          "plus_code": null,
          "road": "Route d'Abatta",
          "sublocality": null,
          'latitude': 4.7,
          'longitude': -3.9,
        };
        //assert
        expect(result, equals(tExpectedMap));
      },
    );
  });
}
