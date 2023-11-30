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


void requestPermissions() async {
  // Liste des autorisations nécessaires pour ton application
  List<Permission> permissions = [
    Permission.camera,
    Permission.storage,
    // Ajoute d'autres autorisations au besoin
  ];

  // Demande les autorisations
  Map<Permission, PermissionStatus> statuses = await permissions.request();

  // Vérifie si toutes les autorisations ont été accordées
  bool allGranted = statuses.values.every((status) => status == PermissionStatus.granted);

  if (!allGranted) {
    // Traite le cas où toutes les autorisations ne sont pas accordées
    // Peut afficher un message à l'utilisateur ou le rediriger vers les paramètres de l'appareil.
  }
}
