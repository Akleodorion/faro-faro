import 'package:faro_clean_tdd/core/util/permission_handler/enum/permission_enum.dart';
import 'package:faro_clean_tdd/core/util/permission_handler/methods/permission_request_dialog.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class PermissionHandler {
  Future<PermissionStatus> requestPermission({
    required BuildContext context,
    required PermissionEnum permissionEnum,
  });
  Future<PermissionStatus> requestPermissionStatus(
      {required PermissionEnum permissionEnum});
}

class PermissionHandlerImp implements PermissionHandler {
  final Map<PermissionEnum, Permission> permissionMap = {
    PermissionEnum.camera: Permission.camera,
    PermissionEnum.contact: Permission.contacts,
    PermissionEnum.location: Permission.location,
    PermissionEnum.photos: Permission.photos,
  };

  @override
  Future<PermissionStatus> requestPermission(
      {required BuildContext context,
      required PermissionEnum permissionEnum}) async {
    await permissionRequestDialog(
        context: context, permissionEnum: permissionEnum, isSuccess: true);

    final PermissionStatus result =
        await permissionMap[permissionEnum]!.request();
    return result;
  }

  @override
  Future<PermissionStatus> requestPermissionStatus(
      {required PermissionEnum permissionEnum}) async {
    return await permissionMap[permissionEnum]!.status;
  }
}
