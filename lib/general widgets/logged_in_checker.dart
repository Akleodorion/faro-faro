// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/features/user_authentification/presentation/pages/auth_screen_page.dart';
import 'package:faro_faro/features/user_authentification/presentation/providers/logged_in/logged_in_provider.dart';
import 'package:faro_faro/features/user_authentification/presentation/providers/logged_in/state/logged_in_state.dart';
import 'package:faro_faro/pages/main_page/main_page.dart';

class LoggedInChecker extends ConsumerStatefulWidget {
  const LoggedInChecker({super.key});

  @override
  ConsumerState<LoggedInChecker> createState() => _LoggedInCheckerState();
}

class _LoggedInCheckerState extends ConsumerState<LoggedInChecker> {
  Future<LoggedInState> _checkedLogStatus() async {
    final state = ref.watch(loggedInProvider);
    return state;
  }

  @override
  void initState() {
    ref.read(loggedInProvider.notifier).logInWithToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkedLogStatus(),
      builder: (context, snapshot) {
        return provideScreenToDisplay(state: snapshot.data);
      },
    );
  }
}

Widget provideScreenToDisplay({required LoggedInState? state}) {
  if (state is Loaded) {
    return const MainPage();
  }
  if (state is Unloaded) {
    return const AuthScreen();
  }
  return const Center(
    child: CircularProgressIndicator(),
  );
}
