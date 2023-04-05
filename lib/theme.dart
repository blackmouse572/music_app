import 'package:flutter/material.dart';

//Gray color scheme from Chakra UI
class Gray {
  static const Color gray50 = Color(0xFFFAFAFA);
  static const Color gray100 = Color(0xFFF5F5F5);
  static const Color gray200 = Color(0xFFEEEEEE);
  static const Color gray300 = Color.fromRGBO(203, 213, 224, 1);
  static const Color gray400 = Color.fromRGBO(160, 174, 192, 1);
  static const Color gray500 = Color.fromRGBO(113, 128, 150, 1);
  static const Color gray600 = Color(0xFF4A5568);
  static const Color gray700 = Color.fromRGBO(45, 55, 72, 1);
  static const Color gray800 = Color.fromRGBO(26, 32, 44, 1);
  static const Color gray900 = Color.fromRGBO(17, 24, 39, 1);
}

//Orange color scheme from Chakra UI
class Primary {
  static const Color primary50 = Color(0xFFFFFAF0);
  static const Color primary100 = Color(0xFFFEEBC8);
  static const Color primary200 = Color(0xFFFBD38D);
  static const Color primary300 = Color(0xFFF6AD55);
  static const Color primary400 = Color(0xFFED8936);
  static const Color primary500 = Color(0xFFDD6B20);
  static const Color primary600 = Color(0xFFC05621);
  static const Color primary700 = Color(0xFF9C4221);
  static const Color primary800 = Color(0xFF7B341E);
  static const Color primary900 = Color(0xFF652B19);
}

final chakraTheme = ThemeData(
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      elevation: 0,
      iconTheme: const IconThemeData(color: Primary.primary600),
      toolbarTextStyle: const TextTheme(
        titleLarge: TextStyle(
          color: Primary.primary400,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ).titleLarge,
      titleTextStyle: const TextTheme(
        titleLarge: TextStyle(
          color: Primary.primary400,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ).titleLarge,
    ),
    //Background color of the whole app #2D3748
    scaffoldBackgroundColor: Colors.white,
    dividerColor: const Color(0xFFCBD5E0),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: Gray.gray400,
        fontWeight: FontWeight.bold,
        fontSize: 48,
      ),
      titleMedium: TextStyle(
        color: Gray.gray400,
        fontWeight: FontWeight.bold,
        fontSize: 36,
      ),
      titleSmall: TextStyle(
        color: Gray.gray400,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      bodyLarge: TextStyle(
        color: Gray.gray400,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
      bodySmall: TextStyle(
        color: Gray.gray500,
        fontSize: 10,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Primary.primary500,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Primary.primary800),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    ),
    colorScheme: ColorScheme.fromSwatch(
        backgroundColor: Gray.gray800,
        primaryColorDark: Gray.gray500,
        primarySwatch: const MaterialColor(
          //Primary color = primary.500 #DD6B20
          0xFFDD6B20,
          {
            50: Primary.primary50,
            100: Primary.primary100,
            200: Primary.primary200,
            300: Primary.primary300,
            400: Primary.primary400,
            500: Primary.primary500,
            600: Primary.primary600,
            700: Primary.primary700,
            800: Primary.primary800,
            900: Primary.primary900,
          },
        )));
