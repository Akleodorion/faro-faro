import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/auto_login/auto_login_provider.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/auto_login/state/auto_login_state.dart';
import 'package:faro_clean_tdd/widgets/autch_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AutoLoginChecker extends ConsumerStatefulWidget {
  const AutoLoginChecker({super.key});

  @override
  ConsumerState<AutoLoginChecker> createState() => _AutchCheckerState();
}

class _AutchCheckerState extends ConsumerState<AutoLoginChecker> {
  Future<AutoLoginState> _checkUserAuth() async {
    final state = ref.watch(autoLoginProvider);
    return state;
  }

  @override
  void initState() {
    super.initState();
    autoLogin();
  }

  void autoLogin() async {
    await ref.read(autoLoginProvider.notifier).getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkUserAuth(),
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state is Loaded) {
          return const AuthChecker();
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
