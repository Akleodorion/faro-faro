// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:faro_faro/core/util/text_field_enum.dart';
import 'package:faro_faro/features/user_authentification/presentation/widgets/constants/constants.dart';
import 'package:faro_faro/features/user_authentification/presentation/widgets/my_text_form_field.dart';
import 'package:faro_faro/features/user_authentification/presentation/widgets/remember_checkbox.dart';

List<Widget> setListOfTextFormField({
  required Map<String, dynamic> logInInfo,
  required bool isLogingIn,
  required Function(String key, String value) onSave,
}) {
  return [
    MyTextFormField(
      key: ValueKey(Random()),
      label: Strings.email,
      intialValue: logInInfo["email"] ?? '',
      onSaved: (value) {
        onSave(
          "email",
          value,
        );
      },
      type: TextFieldType.email,
    ),
    const SizedBox(
      height: 10,
    ),
    MyTextFormField(
      key: ValueKey(
        Random(),
      ),
      label: Strings.password,
      intialValue: logInInfo["password"] ?? '',
      onSaved: (value) {
        onSave(
          "password",
          value,
        );
      },
      type: TextFieldType.password,
    ),
    const SizedBox(
      height: 10,
    ),
    if (!isLogingIn)
      MyTextFormField(
        key: ValueKey(
          Random(),
        ),
        label: Strings.userName,
        intialValue: logInInfo["username"] ?? '',
        onSaved: (value) {
          onSave(
            "username",
            value,
          );
        },
        type: TextFieldType.text,
      ),
    if (!isLogingIn)
      const SizedBox(
        height: 10,
      ),
    if (!isLogingIn)
      MyTextFormField(
          key: ValueKey(Random()),
          label: Strings.phoneNumber,
          intialValue: logInInfo["phoneNumber"] ?? '',
          onSaved: (value) {
            onSave(
              "phoneNumber",
              value,
            );
          },
          type: TextFieldType.number),
    if (!isLogingIn)
      const SizedBox(
        height: 10,
      ),
    RememberCheckbox(
      isChecked: logInInfo["pref"] ?? false,
    ),
  ];
}
