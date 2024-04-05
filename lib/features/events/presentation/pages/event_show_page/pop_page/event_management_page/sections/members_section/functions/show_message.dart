import 'package:faro_clean_tdd/core/util/show_result_message_snackbar.dart';
import 'package:flutter/material.dart';

void showMessage(BuildContext context, String message) {
  if (context.mounted) {
    showResultMessageSnackbar(context: context, message: message);
  }
}
