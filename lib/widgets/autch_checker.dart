import 'package:faro_clean_tdd/features/user_authentification/presentation/pages/auth_screen_page.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/user_auth/state/user_state.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/user_auth/user_provider.dart';
import 'package:faro_clean_tdd/pages/main_page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthChecker extends ConsumerStatefulWidget {
  const AuthChecker({super.key});

  @override
  ConsumerState<AuthChecker> createState() => _AutchCheckerState();
}

class _AutchCheckerState extends ConsumerState<AuthChecker> {
  Future<UserState> _checkUserAuth() async {
    final state = ref.watch(userAuthProvider);
    return state;
  }

  @override
  void initState() {
    super.initState();
    logInWithToken();
  }

  void logInWithToken() async {
    await ref.read(userAuthProvider.notifier).logInWithToken();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkUserAuth(),
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state is Loaded) {
          return const MainPage();
        }
        return const AuthScreen();
      },
    );
  }
}
