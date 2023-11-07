import 'package:faro_clean_tdd/features/address/domain/entities/address.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AddressModel extends Address {
  const AddressModel(
      {required super.latitude,
      required super.longitude,
      required super.addressName,
      required super.geocodeUrl});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
        latitude: json["results"][0]["geometry"]["location"]["lat"],
        longitude: json["results"][0]["geometry"]["location"]["lng"],
        addressName: json["results"][0]["formatted_address"],
        geocodeUrl:
            "https://maps.googleapis.com/maps/api/staticmap?center=${json["results"][0]["geometry"]["location"]["lat"]},${json["results"][0]["geometry"]["location"]["lng"]}&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C${json["results"][0]["geometry"]["location"]["lat"]},${json["results"][0]["geometry"]["location"]["lng"]}&key=${dotenv.env['API_KEY']}");
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'addressName': addressName,
    };
  }
}
