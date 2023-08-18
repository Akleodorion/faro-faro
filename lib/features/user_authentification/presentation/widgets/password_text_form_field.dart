import 'package:flutter/material.dart';

class PasswordTextFormField extends StatelessWidget {
  final String intialValue;
  final void Function(String text) onSaved;

  const PasswordTextFormField(
      {super.key, required this.intialValue, required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: intialValue,
      decoration: const InputDecoration(
        label: Text('Password'),
      ),
      obscureText: true,
      autocorrect: false,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.trim() == '' || value.trim().length < 6) {
          return 'Enter a valid password min 6 chars.';
        }
        return null;
      },
      onSaved: (newValue) {
        // on enverra la valeur actuelle au form.
        onSaved(newValue!);
      },
    );
  }
}
