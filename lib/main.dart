import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/state/user_state.dart';
import 'package:faro_clean_tdd/features/user_authentification/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/user_authentification/presentation/pages/auth_screen_page.dart';
import 'home_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAuth = ref.watch(userAuthProvider);

    if (userAuth is Initial) {}
    return MaterialApp(
      title: 'Faro App',
      home: userAuth is Loaded ? const HomePage() : const AuthScreen(),
    );
  }
}
