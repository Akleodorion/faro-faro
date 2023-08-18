import 'dart:math';

import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/user_provider.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/widgets/email_text_form_field.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/widgets/password_text_form_field.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/widgets/remember_checkbox.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/widgets/usecase_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthCard extends ConsumerStatefulWidget {
  const AuthCard({super.key});

  @override
  ConsumerState<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends ConsumerState<AuthCard> {
  final _formKey = GlobalKey<FormState>();
  String? _enteredEmail;
  String? _enteredPassword;
  bool? _isChecked;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(186, 186, 186, 0.1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 45, vertical: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    EmailTextFormField(
                      key: ValueKey(Random()),
                      onSaved: (value) {
                        setState(() {
                          _enteredEmail = value;
                        });
                      },
                      intialValue: _enteredEmail ?? '',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    PasswordTextFormField(
                      intialValue: _enteredPassword ?? '',
                      key: ValueKey(Random()),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RememberCheckbox(
                      isChecked: _isChecked ?? false,
                      onSwitch: (value) {
                        setState(() {
                          _isChecked = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        UsecaseElevatedButton(
                          usecaseTitle: "LogIn",
                          onUsecaseCall: () {
                            ref
                                .read(userAuthProvider.notifier)
                                .logUserIn('test@gmail.com', '123456');
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        TextButton(onPressed: () {}, child: const Text('data'))
                      ],
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}