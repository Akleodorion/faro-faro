// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:faro_faro/core/util/show_result_message_snackbar.dart';

void showMessage(BuildContext context, String message) {
  if (context.mounted) {
    showResultMessageSnackbar(context: context, message: message);
  }
}
