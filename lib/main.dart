import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'features/user_authentification/presentation/providers/state/user_state.dart';
import 'features/user_authentification/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/user_authentification/presentation/pages/auth_screen_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'pages/main_page.dart';
import 'injection_container.dart' as di;

final theme = ThemeData(
  useMaterial3: true,

  datePickerTheme: const DatePickerThemeData(
    backgroundColor: Color.fromRGBO(42, 43, 42, 1),
  ),

  //! Buttons
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: const Color.fromRGBO(243, 255, 198, 1),
      textStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.underline,
      ),
    ),
  ),

  //! Text
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Color.fromRGBO(235, 240, 217, 1),
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 12,
      color: Color.fromRGBO(235, 240, 217, 1),
    ),
    titleSmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 10,
      color: Color.fromRGBO(235, 240, 217, 1),
    ),
    headlineSmall: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 12,
        color: Color.fromRGBO(243, 255, 198, 1),
        decoration: TextDecoration.underline),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      color: Color.fromRGBO(235, 240, 217, 1),
    ),
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: Color.fromRGBO(235, 240, 217, 1),
    ),
  ),

  //! Colors
  colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color.fromRGBO(243, 255, 198, 1),
      onPrimary: Color.fromRGBO(42, 43, 42, 1),
      secondary: Color.fromRGBO(235, 240, 217, 1),
      onSecondary: Color.fromRGBO(42, 43, 42, 1),
      error: Colors.red,
      onError: Color.fromRGBO(42, 43, 42, 1),
      background: Color.fromRGBO(42, 43, 42, 1),
      onBackground: Color.fromRGBO(235, 240, 217, 1),
      surface: Color.fromRGBO(243, 255, 198, 0.15),
      onSurface: Color.fromRGBO(235, 240, 217, 1)),
);

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
        theme: theme,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: const [
          Locale('fr', 'FR'),
        ],
        home: userAuth is Loaded ? const MainPage() : const AuthScreen());
  }
}
