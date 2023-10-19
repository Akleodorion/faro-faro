import 'package:faro_clean_tdd/features/address/domain/entities/address.dart';

class AddressModel extends Address {
  const AddressModel(
      {required super.latitude,
      required super.longitude,
      required super.addressName});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
        latitude: json["results"][0]["geometry"]["location"]["lat"],
        longitude: json["results"][0]["geometry"]["location"]["lng"],
        addressName: json["results"][0]["formatted_address"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'addressName': addressName,
    };
  }
}
