import 'package:faro_clean_tdd/core/util/email_validator.dart';
import 'package:flutter/material.dart';

class EmailTextFormField extends StatelessWidget {
  final String intialValue;
  final void Function(String text) onSaved;

  const EmailTextFormField(
      {super.key, required this.intialValue, required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: intialValue,
      decoration: const InputDecoration(
        label: Text('email'),
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        // appeler une fonction de validation d'email de notre choix.
        return EmailValidationImpl().isEmailValid(value!);
      },
      onSaved: (value) {
        onSaved(value!);
      },
    );
  }
}
