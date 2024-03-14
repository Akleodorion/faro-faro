import 'package:flutter/material.dart';

class UsecaseElevatedButton extends StatelessWidget {
  const UsecaseElevatedButton({
    super.key,
    required this.usecaseTitle,
    required this.onUsecaseCall,
  });

  final String usecaseTitle;
  final void Function() onUsecaseCall;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Confirmation requise"),
              content: const Text(
                  "L'évènement va être crée. Vous ne pourrez pas le modiifier par la suite.\nNous vous invitons donc à vérifier les informations."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Modifier"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onUsecaseCall();
                  },
                  child: const Text("Confirmer"),
                )
              ],
            );
          },
        );
      },
      child: Text(
        usecaseTitle,
      ),
    );
  }
}
