import 'package:faro_clean_tdd/core/util/permission_handler/constants/permission_constants.dart';
import 'package:faro_clean_tdd/core/util/permission_handler/enum/permission_enum.dart';
import 'package:faro_clean_tdd/core/util/permission_handler/methods/content_text.dart';
import 'package:faro_clean_tdd/widgets/alert_dialog/Info_alert_dialog/info_alert_dialog.dart';
import 'package:flutter/material.dart';

/// This function shows an alert dialog.
///
/// it take a [PermissionEnum] as parameter.
///
/// it will display the corresponding content of the enum selected.
Future<void> permissionRequestDialog(
    {required BuildContext context,
    required PermissionEnum permissionEnum,
    required bool isSuccess}) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return InfoAlertDialog(
        title: PermissionConstants.title,
        content: contentText(requestEnum: permissionEnum, isSuccess: isSuccess),
      );
    },
  );
}
