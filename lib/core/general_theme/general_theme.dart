import 'package:faro_clean_tdd/core/util/size_info.dart';
import 'package:flutter/material.dart';

ThemeData getTheme(BuildContext context) {
  final double screenWidth = SizeInfo(context: context).width;
  late double titleLargeFontSize;
  late double titleMediumFontSize;
  late double titleSmallFontSize;
  late double headlineSmallFontSize;
  late double bodyLargeFontSize;
  late double bodyMediumFontSize;
  late double bodySmallFontSize;
  late double iconSize;

  final bool screenWidthIsMini = screenWidth < 350;
  final bool screenWidthIsStandard = screenWidth >= 350 && screenWidth <= 415;
  final bool screenWidthIsLarge = screenWidth > 415;

  if (screenWidthIsLarge) {
    titleLargeFontSize = 20;
    titleMediumFontSize = 18;
    titleSmallFontSize = 16;
    headlineSmallFontSize = 18;
    bodyLargeFontSize = 16;
    bodyMediumFontSize = 14;
    bodySmallFontSize = 12;
    iconSize = 30;
  }

  if (screenWidthIsStandard) {
    titleLargeFontSize = 18;
    titleMediumFontSize = 16;
    titleSmallFontSize = 14;
    headlineSmallFontSize = 16;
    bodyLargeFontSize = 14;
    bodyMediumFontSize = 12;
    bodySmallFontSize = 10;
    iconSize = 28;
  }

  if (screenWidthIsMini) {
    titleLargeFontSize = 14;
    titleMediumFontSize = 12;
    titleSmallFontSize = 10;
    headlineSmallFontSize = 10;
    bodyLargeFontSize = 12;
    bodyMediumFontSize = 10;
    bodySmallFontSize = 8;
    iconSize = 24;
  }

  late final TextTheme textTheme;
  textTheme = TextTheme(
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: titleLargeFontSize,
      color: const Color.fromRGBO(235, 240, 217, 1),
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: titleMediumFontSize,
      color: const Color.fromRGBO(235, 240, 217, 1),
    ),
    titleSmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: titleSmallFontSize,
      color: const Color.fromRGBO(235, 240, 217, 1),
    ),
    headlineSmall: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: headlineSmallFontSize,
        color: const Color.fromRGBO(243, 255, 198, 1),
        decoration: TextDecoration.underline),
    bodySmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: bodySmallFontSize,
      color: const Color.fromRGBO(235, 240, 217, 1),
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: bodyMediumFontSize,
      color: const Color.fromRGBO(235, 240, 217, 1),
    ),
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: bodyLargeFontSize,
      color: const Color.fromRGBO(235, 240, 217, 1),
    ),
  );

  return ThemeData(
    useMaterial3: true,
    datePickerTheme: const DatePickerThemeData(
      backgroundColor: Color.fromRGBO(42, 43, 42, 1),
    ),

    //! Text
    textTheme: textTheme,

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
      onSurface: Color.fromRGBO(235, 240, 217, 1),
    ),

    //! Buttons
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color.fromRGBO(243, 255, 198, 1),
        textStyle: TextStyle(
          fontSize: titleSmallFontSize,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline,
        ),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        textStyle: TextStyle(
            fontSize: titleMediumFontSize, fontWeight: FontWeight.w600),
        backgroundColor: const Color.fromRGBO(243, 255, 198, 1),
        foregroundColor: const Color.fromRGBO(42, 43, 42, 1),
      ),
    ),

    //! Icons
    iconTheme: IconThemeData(
      color: const Color.fromRGBO(243, 255, 198, 1),
      size: iconSize,
    ),

    //! Others
    bottomNavigationBarTheme: const BottomNavigationBarThemeData().copyWith(
      selectedItemColor: const Color.fromRGBO(235, 240, 217, 1),
      selectedLabelStyle: TextStyle(fontSize: titleLargeFontSize),
      unselectedLabelStyle: TextStyle(fontSize: titleSmallFontSize),
      unselectedItemColor:
          const Color.fromRGBO(235, 240, 217, 1).withOpacity(0.5),
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
    ),
  );
}
