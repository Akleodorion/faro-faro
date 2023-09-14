import 'dart:math';

import 'package:faro_clean_tdd/core/util/text_field_enum.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/user_provider.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/widgets/my_text_button.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/widgets/my_text_form_field.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/widgets/remember_checkbox.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/widgets/usecase_elevated_button.dart';
import 'package:faro_clean_tdd/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/state/user_state.dart';

class AuthCard extends ConsumerStatefulWidget {
  const AuthCard({super.key});

  @override
  ConsumerState<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends ConsumerState<AuthCard> {
  final _formKey = GlobalKey<FormState>();
  bool logingIn = true;
  String? _enteredEmail;
  String? _enteredPassword;
  String? _enteredUsername;
  String? _enteredPhoneNumber;
  bool? _isChecked;

  @override
  void initState() {
    super.initState();
    final values = ref.read(userAuthProvider);
    if (values is Initial) {
      _enteredEmail = values.userInfo["email"];
      _enteredPassword = values.userInfo["password"];
      _isChecked = values.userInfo["pref"];
    }
  }

  void _userLogin() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final currentState = ref.read(userAuthProvider);
      if (currentState is Initial) {
        _isChecked = currentState.userInfo["pref"];
      }
      final state = await ref
          .read(userAuthProvider.notifier)
          .logUserIn(_enteredEmail!, _enteredPassword!, _isChecked!);
      if (state is Error) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: theme.colorScheme.surface,
            content: Text(
              state.message,
              style: TextStyle(
                  // ignore: use_build_context_synchronously
                  color: theme.colorScheme.secondary),
            )));
      }
    }
  }

  void _userSignIn() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final state = await ref.read(userAuthProvider.notifier).signUserIn(
          _enteredEmail!,
          _enteredPassword!,
          _enteredPhoneNumber!,
          _enteredUsername!,
          _isChecked!);
      if (state is Error) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: theme.colorScheme.surface,
            content: Text(
              state.message,
              style: TextStyle(
                  // ignore: use_build_context_synchronously
                  color: theme.colorScheme.secondary),
            )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: kElevationToShadow[3],
              borderRadius: BorderRadius.circular(5),
            ),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 45),
                      child: Column(
                        children: [
                          MyTextFormField(
                              key: ValueKey(Random()),
                              label: 'email',
                              intialValue: _enteredEmail ?? '',
                              onSaved: (value) {
                                setState(() {
                                  _enteredEmail = value;
                                });
                              },
                              type: TextFieldType.email),
                          const SizedBox(
                            height: 10,
                          ),
                          MyTextFormField(
                              key: ValueKey(Random()),
                              label: 'password',
                              intialValue: _enteredPassword ?? '',
                              onSaved: (value) {
                                setState(() {
                                  _enteredPassword = value;
                                });
                              },
                              type: TextFieldType.password),
                          const SizedBox(
                            height: 10,
                          ),
                          if (!logingIn)
                            MyTextFormField(
                                key: ValueKey(Random()),
                                label: "Nom d'utilisateur",
                                intialValue: _enteredUsername ?? '',
                                onSaved: (value) {
                                  setState(() {
                                    _enteredUsername = value;
                                  });
                                },
                                type: TextFieldType.text),
                          if (!logingIn)
                            const SizedBox(
                              height: 10,
                            ),
                          if (!logingIn)
                            MyTextFormField(
                                key: ValueKey(Random()),
                                label: 'numéro de téléphone',
                                intialValue: _enteredPhoneNumber ?? '',
                                onSaved: (value) {
                                  setState(() {
                                    _enteredPhoneNumber = value;
                                  });
                                },
                                type: TextFieldType.number),
                          if (!logingIn)
                            const SizedBox(
                              height: 10,
                            ),
                          const RememberCheckbox(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        UsecaseElevatedButton(
                          usecaseTitle:
                              logingIn ? "Connecte-toi" : "Créer son compte",
                          onUsecaseCall: logingIn ? _userLogin : _userSignIn,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        MyTextButton(
                            text: logingIn
                                ? 'Créer un compte'
                                : " j'ai déjà un compte",
                            onPressed: () {
                              setState(() {
                                logingIn = !logingIn;
                              });
                            })
                      ],
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
