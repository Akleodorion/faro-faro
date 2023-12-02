import 'package:permission_handler/permission_handler.dart';

abstract class PermissionRequester {
  Future<PermissionStatus> requestContactPermission();
}

class PermissionRequesterImpl implements PermissionRequester {
  @override
  Future<PermissionStatus> requestContactPermission() async {
    return Permission.location.request();
  }
}
