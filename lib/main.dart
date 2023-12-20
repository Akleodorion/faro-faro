import 'package:faro_clean_tdd/core/general_theme/general_theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'features/user_authentification/presentation/providers/state/user_state.dart';
import 'features/user_authentification/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/user_authentification/presentation/pages/auth_screen_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'pages/main_page/main_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR', null);
  await di.init();
  await dotenv.load(fileName: ".env");

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAuth = ref.watch(userAuthProvider);

    return MaterialApp(
      title: 'Faro App',
      theme: getTheme(context),
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('fr', 'FR'),
      ],
      home: userAuth is Loaded ? const MainPage() : const AuthScreen(),
    );
  }
}
