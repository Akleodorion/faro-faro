import '../providers/state/user_state.dart';
import '../widgets/auth_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/user_provider.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  Future<UserState>? _authFuture;

  @override
  void initState() {
    super.initState();
    _authFuture = _initializeAuth();
  }

  Future<UserState> _initializeAuth() async {
    final userAuth = await ref.read(userAuthProvider.notifier).logInWithToken();
    return userAuth;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserState>(
      future: _authFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
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
              child: const Center(child: CircularProgressIndicator()),
            ),
          );
        } else {
          final userAuth = snapshot.data;
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
              child: userAuth is Initial
                  ? const AuthCard()
                  : const Center(child: CircularProgressIndicator()),
            ),
          );
        }
      },
    );
  }
}
