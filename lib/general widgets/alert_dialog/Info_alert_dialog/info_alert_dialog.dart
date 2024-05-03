import 'package:faro_clean_tdd/general%20widgets/alert_dialog/Info_alert_dialog/iat_constants.dart';
import 'package:flutter/material.dart';

class InfoAlertDialog extends StatelessWidget {
  const InfoAlertDialog({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(IadConstants.disposeText),
        )
      ],
    );
  }
}
