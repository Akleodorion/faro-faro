import 'package:flutter/material.dart';

class EmailTextFormField extends StatelessWidget {
  final String intialValue;

  const EmailTextFormField({super.key, required this.intialValue});

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
        return null;
      },
      onSaved: (newValue) {
        // on enverra la valeur actuelle au form.
      },
    );
  }
}
