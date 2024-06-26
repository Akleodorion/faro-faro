// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/core/util/text_field_enum.dart';
import 'package:faro_faro/features/user_authentification/presentation/providers/password/password_provider.dart';
import 'package:faro_faro/features/user_authentification/presentation/providers/password/state/password_state.dart';
import 'package:faro_faro/features/user_authentification/presentation/widgets/constants/constants.dart';
import 'package:faro_faro/features/user_authentification/presentation/widgets/my_text_form_field.dart';
import 'package:faro_faro/features/user_authentification/presentation/widgets/usecase_elevated_button.dart';

Future<dynamic> forgotPasswordModal(BuildContext context) {
  return showModalBottomSheet(
    backgroundColor: Theme.of(context).colorScheme.tertiary,
    context: context,
    builder: (BuildContext context) {
      return const ForgotPasswordModal();
    },
  );
}

class ForgotPasswordModal extends ConsumerStatefulWidget {
  const ForgotPasswordModal({super.key});

  @override
  ConsumerState<ForgotPasswordModal> createState() =>
      _ForgotPasswordModalState();
}

class _ForgotPasswordModalState extends ConsumerState<ForgotPasswordModal> {
  bool isRequesting = true;
  String? _enteredEmail;
  String? _enteredCode;
  String? _enteredPassword;
  GlobalKey<FormState>? _formKey;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  void _requestToken() async {
    // valider les formulaires.
    if (_formKey!.currentState!.validate()) {
      _formKey!.currentState!.save();

      final state = await ref
          .read(passwordProvider.notifier)
          .requestResetToken(email: _enteredEmail!);

      if (state is Error && mounted) {
        await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Erreur"),
                content: Text(state.message),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Fermer"),
                  )
                ],
              );
            });
        return;
      }

      setState(() {
        isRequesting = !isRequesting;
      });
    }
  }

  void _resetPassword() async {
    if (_formKey!.currentState!.validate()) {
      _formKey!.currentState!.save();

      final state = await ref.read(passwordProvider.notifier).resetPassword(
          email: _enteredEmail!,
          token: _enteredCode!,
          newPassword: _enteredPassword!);

      if (state is Error && mounted) {
        // résultat négatif. affiche une alerte.
        await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Erreur"),
                content: Text(state.message),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Fermer"),
                  )
                ],
              );
            });
        return;
      }

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Le mot de passe a été changé avec succès",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onTertiary,
                  fontSize: 16),
            ),
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Text title = const Text('Récupération du mot de passe');
    String ctaName = "recevoir un code";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 35),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            title,
            const SizedBox(
              height: 20,
            ),
            if (isRequesting)
              MyTextFormField(
                  key: ValueKey(Random()),
                  label: Strings.email,
                  intialValue: '',
                  onSaved: (value) {
                    _enteredEmail = value;
                  },
                  type: TextFieldType.email),
            if (isRequesting)
              const SizedBox(
                height: 20,
              ),
            if (!isRequesting)
              MyTextFormField(
                  key: ValueKey(Random()),
                  label: "Code de récupération",
                  intialValue: '',
                  onSaved: (value) {
                    _enteredCode = value;
                  },
                  type: TextFieldType.text),
            if (!isRequesting)
              const SizedBox(
                height: 20,
              ),
            if (!isRequesting)
              MyTextFormField(
                  key: ValueKey(
                    Random(),
                  ),
                  label: "mot de passe",
                  intialValue: '',
                  onSaved: (value) {
                    setState(() {
                      _enteredPassword = value;
                    });
                  },
                  type: TextFieldType.password),
            const SizedBox(
              height: 20,
            ),
            Consumer(
              builder: (context, WidgetRef ref, child) {
                final state = ref.watch(passwordProvider);
                final isLoading = state is Loading;
                return UsecaseElevatedButton(
                  usecaseTitle: ctaName,
                  onUsecaseCall: isRequesting ? _requestToken : _resetPassword,
                  isLoading: isLoading,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
