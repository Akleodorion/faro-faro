// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:faro_faro/general%20widgets/alert_dialog/Info_alert_dialog/iat_constants.dart';

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
