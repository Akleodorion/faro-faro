import 'package:faro_clean_tdd/features/user_authentification/presentation/widgets/auth_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/state/user_state.dart';
import '../providers/user_provider.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(userAuthProvider.notifier).logInWithToken();
  }

  @override
  Widget build(BuildContext context) {
    final userAuth = ref.watch(userAuthProvider);
    late Widget content;

    if (userAuth is Initial) {
      content = const AuthCard();
    } else {
      content = const Center(child: CircularProgressIndicator());
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
