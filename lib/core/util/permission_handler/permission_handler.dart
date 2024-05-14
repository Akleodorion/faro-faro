import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/core/util/permission_handler/constants/permission_constants.dart';
import 'package:faro_clean_tdd/core/util/permission_handler/enum/permission_enum.dart';
import 'package:faro_clean_tdd/core/util/permission_handler/methods/content_text.dart';
import 'package:faro_clean_tdd/general%20widgets/alert_dialog/Info_alert_dialog/info_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class PermissionHandler {
  /// This function requests the permission for a specific feature.
  ///
  /// If an error occurs throws a [UtilException] the permission hasn't been grated.
  Future<void> requestPermission();

  /// This function shows an alert dialog.
  ///
  /// it take a [PermissionEnum] as parameter.
  ///
  /// it will display the corresponding content of the enum selected.
  Future<void> showPermissionErrorDialog();
}

class PermissionHandlerImp implements PermissionHandler {
  final BuildContext context;
  final PermissionEnum permissionEnum;

  PermissionHandlerImp({
    required this.context,
    required this.permissionEnum,
  });

  @override
  Future<void> requestPermission() async {
    PermissionStatus status =
        await _requestPermissionStatus(permissionEnum: permissionEnum);

    print(status);
    final permissionDenied = (status == PermissionStatus.denied);
    if (permissionDenied && context.mounted) {
      await _showPermissionDialog(
        context: context,
        permissionEnum: permissionEnum,
      );
      print(permissionEnum);
      status = await _requestPermission(permissionEnum: permissionEnum);
      print(status);
    }

    final permissionNotGranted = (status != PermissionStatus.granted);
    if (permissionNotGranted) {
      throw UtilException();
    }
  }

  Future<PermissionStatus> _requestPermissionStatus(
      {required PermissionEnum permissionEnum}) async {
    return await PermissionConstants.permissionMap[permissionEnum]!.status;
  }

  Future<void> _showPermissionDialog({
    required BuildContext context,
    required PermissionEnum permissionEnum,
  }) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return InfoAlertDialog(
          title: PermissionConstants.title,
          content: contentText(
            requestEnum: permissionEnum,
            isSuccess: true,
          ),
        );
      },
    );
  }

  Future<PermissionStatus> _requestPermission(
      {required PermissionEnum permissionEnum}) async {
    return await PermissionConstants.permissionMap[permissionEnum]!.request();
  }

  @override
  Future<void> showPermissionErrorDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return InfoAlertDialog(
          title: PermissionConstants.title,
          content: contentText(
            requestEnum: permissionEnum,
            isSuccess: false,
          ),
        );
      },
    );
  }
}
