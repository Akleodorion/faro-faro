import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class PermissionHandler {
  Future<PermissionStatus> requestContact({BuildContext? context});
}

class PermissionHandlerImp implements PermissionHandler {
  @override
  Future<PermissionStatus> requestContact({BuildContext? context}) async {
    final bool isContextPresent = context != null;

    if (!isContextPresent) {
      final PermissionStatus result = await Permission.contacts.request();
      return result;
    } else {
      await dialogPopUp(context: context, featureNeeded: "liste de contact");
      final PermissionStatus result = await Permission.contacts.request();
      return result;
    }
  }

  Future dialogPopUp(
      {required BuildContext context, required String featureNeeded}) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Permission requise."),
            content: Text(
                "Cette fonctionnalité à besoin d'un accès à votre $featureNeeded."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Continuer"),
              )
            ],
          );
        });
  }
}
