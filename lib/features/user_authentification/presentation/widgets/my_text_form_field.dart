import 'package:flutter/material.dart';

import '../../../../core/util/email_validator.dart';

class MyTextFormField extends StatelessWidget {
  final String intialValue;
  final String type;
  final void Function(String text) onSaved;
  const MyTextFormField(
      {super.key,
      required this.intialValue,
      required this.onSaved,
      required this.type});

  @override
  Widget build(BuildContext context) {
    TextInputType inputType = TextInputType.text;
    bool isPassword = false;

    String? Function(String value) validation = (value) {
      return null;
    };

    if (type == "password") {
      isPassword = true;
      validation = (value) {
        if (value.trim() == '' || value.trim().length < 6) {
          return 'Enter a valid password min 6 chars.';
        }
        return null;
      };
    }

    if (type == "email") {
      inputType = TextInputType.emailAddress;
      validation = (value) {
        return EmailValidationImpl().isEmailValid(value);
      };
    }

    return Container(
      height: 65,
      decoration:
          BoxDecoration(color: Theme.of(context).colorScheme.background),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: TextFormField(
          initialValue: intialValue,
          decoration: InputDecoration(
            label: Text(
              type,
              style: const TextStyle(fontSize: 12),
            ),
          ),
          autocorrect: false,
          obscureText: isPassword,
          keyboardType: inputType,
          validator: (value) {
            return validation(value!);
          },
          onSaved: (value) {
            onSaved(value!);
          },
        ),
      ),
    );
  }
}
