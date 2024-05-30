// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/features/user_authentification/presentation/pages/auth_screen_page.dart';
import 'package:faro_faro/features/user_authentification/presentation/providers/user_auth/state/user_state.dart';
import 'package:faro_faro/features/user_authentification/presentation/providers/user_auth/user_provider.dart';
import 'package:faro_faro/pages/main_page/main_page.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkUserAuth(),
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state is Loaded) {
          return const MainPage();
        } else if (state is Unloaded) {
          return const AuthScreen();
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
