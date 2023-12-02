import 'package:location/location.dart';

abstract class GetLocation {
  Future<Map<String, double>?>? getLocation();
}

class GetLocationImpl implements GetLocation {
  GetLocationImpl({required this.location});

  final Location location;

  @override
  Future<Map<String, double>?>? getLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();

    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    locationData = await location.getLocation();
    final latitude = locationData.latitude;
    final longitude = locationData.longitude;
    return {'latitude': latitude!, 'longitude': longitude!};
  }
}
