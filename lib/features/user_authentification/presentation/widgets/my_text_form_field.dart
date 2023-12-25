import 'package:faro_clean_tdd/core/util/validate_input.dart';
import '../../../../core/util/phone_number_validator.dart';
import '../../../../core/util/text_field_enum.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

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
  late Widget content;
  bool hasError = false;
  double minHeight = 70.0; // Taille minimale
  double maxHeight = 90.0; // Taille maximale en cas d'erreur

  @override
  Widget build(BuildContext context) {
    TextInputType inputType = TextInputType.text;
    bool isPassword = false;

    String? Function(String? value) validation = (value) {
      return null;
    };

    if (widget.type == TextFieldType.password) {
      isPassword = true;
      validation = (value) {
        return ValidateInputImpl().passwordValidator(value);
      };
    }

    if (widget.type == TextFieldType.email) {
      inputType = TextInputType.emailAddress;
      validation = (value) {
        return ValidateInputImpl().isEmailValid(value);
      };
    }

    if (widget.type == TextFieldType.text) {
      inputType = TextInputType.text;
    }

    if (widget.type == TextFieldType.number) {
      validation = (value) {
        return ValidateInputImpl().phoneNumberValidator(value);
      };
      content = InternationalPhoneNumberInput(
        maxLength: 10,
        onInputChanged: (PhoneNumber updateNumber) {
          setState(() {
            number = updateNumber;
          });
        },
        countries: const ['CI', 'BJ', 'SN', 'BF', 'FR', 'ML', 'CM'],
        keyboardType: TextInputType.number,
        formatInput: false,
        selectorTextStyle: Theme.of(context).textTheme.bodyMedium,
        selectorConfig:
            const SelectorConfig(selectorType: PhoneInputSelectorType.DROPDOWN),
        initialValue: number,
        textStyle: Theme.of(context).textTheme.bodyLarge,
        inputDecoration: InputDecoration(
          errorStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.red),
          label: Text(
            widget.label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        validator: (value) {
          if (value == null) {
            return "Field can't be null";
          }
          final result = validation(value);
          if (result != null) {
            setState(() {
              hasError = true;
            });
            return result;
          } else {
            return result;
          }
        },
        onSaved: (value) {
          widget.onSaved(
              PhoneNumberValidatorImpl().parseNumber(value.phoneNumber!));
        },
        autoValidateMode: AutovalidateMode.disabled,
      );
    }

    if (widget.type != TextFieldType.number) {
      content = TextFormField(
        initialValue: widget.intialValue,
        decoration: InputDecoration(
          label: Text(
            widget.label,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        autocorrect: false,
        obscureText: isPassword,
        keyboardType: inputType,
        validator: (value) {
          setState(() => hasError = false);
          final result = validation(value);
          result != null ? setState(() => hasError = true) : null;
          return result;
        },
        onSaved: (value) {
          widget.onSaved(value!);
        },
      );
    }

    return Container(
      decoration:
          BoxDecoration(color: Theme.of(context).colorScheme.background),
      height: hasError ? maxHeight : minHeight,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: content,
      ),
    );
  }
}
