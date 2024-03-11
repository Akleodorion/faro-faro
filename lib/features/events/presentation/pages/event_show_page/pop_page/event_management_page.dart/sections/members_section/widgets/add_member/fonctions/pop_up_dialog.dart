import 'package:flutter/material.dart';

Future popUpDialog({required BuildContext context}) async {
  await showDialog(
    context: context,
    builder: (builder) {
      return AlertDialog(
        title: const Text("Accès liste des contacts"),
        content: const Text(
            "L'application n'a pas reçu l'autorisation d'accès à la liste de contact.\nVeuillez l'activer dans les paramètres du téléphone."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Confirmer",
            ),
          )
        ],
      );
    },
  );
}
