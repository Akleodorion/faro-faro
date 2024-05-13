import 'package:faro_clean_tdd/features/user_authentification/presentation/widgets/auth_card/widgets/auth_card_form/auth_card_form.dart';
import 'package:flutter/material.dart';

class AuthCard extends StatelessWidget {
  const AuthCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: kElevationToShadow[3],
              borderRadius: BorderRadius.circular(5),
            ),
            child: const AuthCardForm(),
          ),
        ),
      ),
    );
  }
}
