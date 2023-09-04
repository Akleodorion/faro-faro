import 'package:faro_clean_tdd/features/user_authentification/presentation/widgets/auth_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/state/user_state.dart';
import '../providers/user_provider.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAuth = ref.watch(userAuthProvider);
    Widget content = const Center(child: CircularProgressIndicator());

    if (userAuth is Loading) {
      ref.read(userAuthProvider.notifier).getUserInfo();
    } else if (userAuth is Initial) {
      content = const AuthCard();
    }
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(42, 43, 42, 1),
                Color.fromRGBO(42, 43, 42, 0.2),
              ],
            ),
          ),
          child: content),
    );
  }
}
