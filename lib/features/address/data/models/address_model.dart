// Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Project imports:
import 'package:faro_faro/features/address/domain/entities/address.dart';

class AddressModel extends Address {
  const AddressModel({
    required super.latitude,
    required super.longitude,
    required super.geocodeUrl,
    required super.country,
    required super.countryCode,
    super.locality,
    super.sublocality,
    super.road,
    super.plusCode,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> addressInfoMap = getInfoFromJson(json);
    return AddressModel(
        latitude: addressInfoMap["latitude"],
        longitude: addressInfoMap["longitude"],
        geocodeUrl: addressInfoMap["geocode_url"],
        country: addressInfoMap["country"],
        countryCode: addressInfoMap["country_code"],
        locality: addressInfoMap["locality"],
        plusCode: addressInfoMap["plus_code"],
        road: addressInfoMap["route"],
        sublocality: addressInfoMap["sublocality"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'geocode_url': geocodeUrl,
      'country': country,
      'country_code': countryCode,
      'locality': locality,
      'plus_code': plusCode,
      'road': road,
      'sublocality': sublocality,
    };
  }
}

Map<String, dynamic> getInfoFromJson(json) {
  final Map<String, dynamic> updatedMap = {};
  final Map<String, dynamic> addressMap = {
    "plus_code": null,
    "route": null,
    "sublocality": null,
    "locality": null,
    "country_code": null,
    "country": null,
    "latitude": json["results"][0]["geometry"]["location"]["lat"],
    "longitude": json["results"][0]["geometry"]["location"]["lng"],
    "geocode_url":
        "https://maps.googleapis.com/maps/api/staticmap?center=${json["results"][0]["geometry"]["location"]["lat"]},${json["results"][0]["geometry"]["location"]["lng"]}&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C${json["results"][0]["geometry"]["location"]["lat"]},${json["results"][0]["geometry"]["location"]["lng"]}&key=${dotenv.env['API_KEY']}"
  };

  final List myArray = json["results"][0]["address_components"];

  for (final value in myArray) {
    final List typesArray = value["types"];

    for (final key in addressMap.keys) {
      if (typesArray.contains(key)) {
        String longName = value["long_name"];
        switch (key) {
          case "country":
            updatedMap["country"] = longName;
            updatedMap["country_code"] = value["short_name"];
            break;
          default:
            updatedMap[key] = longName;
            break;
        }
      }
    }
  }
  addressMap.addAll(updatedMap);
  return addressMap;
}
