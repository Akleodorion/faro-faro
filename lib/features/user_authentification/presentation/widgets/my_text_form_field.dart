import 'package:faro_clean_tdd/core/util/password_validator.dart';
import 'package:faro_clean_tdd/core/util/phone_number_validator.dart';
import 'package:faro_clean_tdd/core/util/text_field_enum.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../../core/util/email_validator.dart';

class MyTextFormField extends StatefulWidget {
  final String intialValue;
  final TextFieldType type;
  final String label;
  final void Function(String text) onSaved;
  const MyTextFormField(
      {super.key,
      required this.intialValue,
      required this.label,
      required this.onSaved,
      required this.type});

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  PhoneNumber number = PhoneNumber(isoCode: 'CI');
  @override
  Widget build(BuildContext context) {
    TextInputType inputType = TextInputType.text;
    bool isPassword = false;

    String? Function(String value) validation = (value) {
      return null;
    };

    Widget content = TextFormField(
      initialValue: widget.intialValue,
      decoration: InputDecoration(
        label: Text(
          widget.label,
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
        widget.onSaved(value!);
      },
    );

    if (widget.type == TextFieldType.password) {
      isPassword = true;
      validation = (value) {
        return PasswordValidatorImpl().passwordValidator(value);
      };
    }

    if (widget.type == TextFieldType.email) {
      inputType = TextInputType.emailAddress;
      validation = (value) {
        return EmailValidationImpl().isEmailValid(value);
      };
    }

    if (widget.type == TextFieldType.text) {
      inputType = TextInputType.text;
    }

    if (widget.type == TextFieldType.number) {
      validation = (value) {
        return PhoneNumberValidatorImpl().phoneNumberValidator(value);
      };
      content = InternationalPhoneNumberInput(
        onInputChanged: (PhoneNumber updateNumber) {
          setState(() {
            number = updateNumber;
          });
        },
        countries: const ['CI', 'BJ', 'SN', 'BF', 'FR', 'ML', 'CM'],
        keyboardType: TextInputType.number,
        selectorTextStyle: const TextStyle(fontSize: 12),
        initialValue: number,
        inputDecoration: InputDecoration(
          label: Text(
            widget.label,
            style: const TextStyle(fontSize: 12),
          ),
        ),
        validator: (value) {
          return validation(value!);
        },
        autoValidateMode: AutovalidateMode.disabled,
      );
    }

    return Container(
      decoration:
          BoxDecoration(color: Theme.of(context).colorScheme.background),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: content,
      ),
    );
  }
}
