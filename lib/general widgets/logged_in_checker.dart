import 'package:faro_clean_tdd/features/user_authentification/presentation/pages/auth_screen_page.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/logged_in/logged_in_provider.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/logged_in/state/logged_in_state.dart';
import 'package:faro_clean_tdd/pages/main_page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
