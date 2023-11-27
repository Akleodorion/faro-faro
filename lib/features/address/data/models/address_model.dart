import 'package:faro_clean_tdd/features/address/domain/entities/address.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AddressModel extends Address {
  const AddressModel({
    required super.latitude,
    required super.longitude,
    required super.geocodeUrl,
    required super.country,
    required super.countryCode,
    required super.town,
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
        town: addressInfoMap["town"],
        plusCode: addressInfoMap["plus_code"],
        road: addressInfoMap["road"],
        sublocality: addressInfoMap["sublocality"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'geocode_url': geocodeUrl,
      'country': country,
      'country_code': countryCode,
      'town': town,
      'plus_code': plusCode,
      'road': road,
      'sublocality': sublocality,
    };
  }
}

Map<String, dynamic> getInfoFromJson(json) {
  final Map<String, dynamic> addressMap = {
    "plus_code": null,
    "road": null,
    "sublocality": null,
    "town": null,
    "country_code": null,
    "country": null,
    "latitude": json["result"][0]["geometry"]["location"]["lat"],
    "longitude": json["result"][0]["geometry"]["location"]["lat"],
    "geocode_url":
        "https://maps.googleapis.com/maps/api/staticmap?center=${json["results"][0]["geometry"]["location"]["lat"]},${json["results"][0]["geometry"]["location"]["lng"]}&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C${json["results"][0]["geometry"]["location"]["lat"]},${json["results"][0]["geometry"]["location"]["lng"]}&key=${dotenv.env['API_KEY']}"
  };

  final List myArray = json["result"][0]["address_components"];

  for (final value in myArray) {
    final List typesArray = value["types"];

    for (final key in addressMap.keys) {
      if (typesArray.contains(key)) {
        String longName = value["LongName"];
        String variableName = addressMap[key];

        switch (variableName) {
          case "country":
            addressMap["country"] = longName;
            addressMap["countryCode"] = value["shortName"];
            break;
          default:
            addressMap[variableName] = longName;
            break;
        }
      }
    }
  }
  return addressMap;
}
