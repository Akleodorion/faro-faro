import 'package:flutter/material.dart';

class UsecaseElevatedButton extends StatelessWidget {
  const UsecaseElevatedButton(
      {super.key, required this.usecaseTitle, required this.onUsecaseCall});

  final String usecaseTitle;
  final void Function() onUsecaseCall;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        elevation: 5,
      ),
      onPressed: onUsecaseCall,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Text(
          usecaseTitle,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
