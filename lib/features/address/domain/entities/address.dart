import 'package:equatable/equatable.dart';

class Address extends Equatable {
  const Address({
    required this.latitude,
    required this.longitude,
    required this.geocodeUrl,
    required this.country,
    required this.countryCode,
    this.locality,
    this.sublocality,
    this.road,
    this.plusCode,
  });

  final String country;
  final String countryCode;
  final String? locality;
  final String? sublocality;
  final String? road;
  final String? plusCode;
  final double latitude;
  final double longitude;
  final String geocodeUrl;

  @override
  List<Object?> get props => [
        latitude,
        longitude,
        geocodeUrl,
        country,
        countryCode,
        locality,
        sublocality,
        road,
        plusCode
      ];

  String getFullAddress() {
    final regularAddressInfoList = [
      road,
      sublocality,
      locality,
      sublocality,
      country,
    ];

    return regularAddressInfoList.where((part) => part != null).join(', ');
  }

  String getLocalityIfPresentElseReturnCountry() {
    final bool isLocalityPresent = locality != null;
    if (isLocalityPresent) {
      return locality!;
    }
    return country;
  }
}
