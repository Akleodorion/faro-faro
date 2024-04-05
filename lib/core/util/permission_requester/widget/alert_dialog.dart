import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  const MyAlertDialog({super.key, required this.featureNeeded});

  final String featureNeeded;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Permission requise.",
      ),
      content: Text(
        "Cette fonctionnalité à besoin d'un accès à votre $featureNeeded.",
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            "Continuer",
          ),
        )
      ],
    );
  }
}
