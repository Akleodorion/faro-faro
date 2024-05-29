import 'package:flutter/material.dart';

void showResultMessageSnackbar(
    {required BuildContext context, required String message}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(
            color: Theme.of(context).colorScheme.onTertiary, fontSize: 16),
      ),
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      duration: const Duration(seconds: 3),
    ),
  );
}
