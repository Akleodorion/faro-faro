import 'package:flutter/material.dart';

class ActionAlertDialog extends StatelessWidget {
  const ActionAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.doThis,
  });

  final String title;
  final String content;
  final void Function() doThis;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.close,
            color: Colors.red,
          ),
        ),
        IconButton(
            onPressed: doThis,
            icon: const Icon(
              Icons.done,
              color: Colors.green,
            )),
      ],
    );
  }
}
