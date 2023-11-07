import 'package:equatable/equatable.dart';

class Address extends Equatable {
  const Address({
    required this.latitude,
    required this.longitude,
    required this.addressName,
    required this.geocodeUrl,
  });

  final double latitude;
  final double longitude;
  final String addressName;
  final String geocodeUrl;

  @override
  List<Object?> get props => [
        latitude,
        longitude,
        addressName,
        geocodeUrl
      ];
}
