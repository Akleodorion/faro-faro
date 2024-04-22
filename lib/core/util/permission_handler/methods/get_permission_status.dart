import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/core/util/permission_handler/enum/permission_enum.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../permission_handler.dart';

/// This function requests the permission for a specific feature.
///
/// If an error occurs throws a [UtilException] the permission hasn't been grated.
Future<void> getPermissionStatus({
  required BuildContext context,
  required PermissionEnum permissionEnum,
}) async {
  final PermissionHandler permissionHandler = PermissionHandlerImp();
  PermissionStatus status = await permissionHandler.requestPermissionStatus(
    permissionEnum: permissionEnum,
  );
  if ((status == PermissionStatus.denied) && context.mounted) {
    status = await permissionHandler.requestPermission(
      context: context,
      permissionEnum: permissionEnum,
    );
  }
  if (status != PermissionStatus.granted) {
    throw UtilException();
  }
}
