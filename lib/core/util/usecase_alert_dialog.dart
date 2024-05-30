// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> usecaseAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
  required Function() usecase,
}) async {
  await showDialog(
    context: context,
    builder: (BuildContext conxtext) {
      return AlertDialog(
        titleTextStyle: const TextStyle(fontSize: 24),
        contentTextStyle: const TextStyle(fontSize: 16),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        content: Text(
          content,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        actions: [
          Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return IconButton(
              onPressed: () async {
                usecase();
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.done,
                color: Colors.green,
              ),
            );
          }),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            ),
          )
        ],
      );
    },
  );
}
