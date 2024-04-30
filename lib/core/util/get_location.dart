import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:location/location.dart';

abstract class GetLocation {
  /// This method return a map
  /// The first information is the latitude, the second is the longitude
  /// If the application does not have the permission it will throw a [UtilException] .
  Future<Map<String, double>?>? getLocation();
}

class GetLocationImpl implements GetLocation {
  GetLocationImpl({required this.location});

  final Location location;

  @override
  Future<Map<String, double>?>? getLocation() async {
    LocationData locationData;
    try {
      locationData = await location.getLocation();
      final latitude = locationData.latitude;
      final longitude = locationData.longitude;
      return {'latitude': latitude!, 'longitude': longitude!};
    } catch (error) {
      throw UtilException();
    }
  }
}
