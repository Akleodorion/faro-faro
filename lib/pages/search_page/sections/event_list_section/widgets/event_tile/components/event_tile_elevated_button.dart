import 'package:flutter/material.dart';

class EventTileElevatedButton extends StatelessWidget {
  const EventTileElevatedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      ),
      child: const Text(
        "Voir plus",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }
}
