import 'package:permission_handler/permission_handler.dart';

abstract class PermissionRequester {
  Future<PermissionStatus> requestContactPermission();
  Future<PermissionStatus> requestCameraPermission();
}

class PermissionRequesterImpl implements PermissionRequester {
  @override
  Future<PermissionStatus> requestContactPermission() async {
    return Permission.location.request();
  }

  @override
  Future<PermissionStatus> requestCameraPermission() {
    return Permission.camera.request();
  }
}
