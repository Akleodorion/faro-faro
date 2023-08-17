import 'package:flutter/material.dart';

class PasswordTextFormField extends StatelessWidget {
  final String intialValue;

  const PasswordTextFormField({super.key, required this.intialValue});

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
        // appeler une fonction de validation de mot de passe de notre choix.
        return null;
      },
      onSaved: (newValue) {
        // on enverra la valeur actuelle au form.
      },
    );
  }
}
