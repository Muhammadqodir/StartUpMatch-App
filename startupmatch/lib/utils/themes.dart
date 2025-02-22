import 'package:flutter/material.dart';

const primaryColor = Color(0xFF012B6F);
const primaryColor1 = Color(0xFF0141A2);
const colorAccent = Color(0xFFE1F2F0);
const lightGray = Color(0xFFcccccc);

const defaiultShadow = BoxShadow(
  color: Color.fromARGB(121, 158, 158, 158),
  spreadRadius: 1,
  blurRadius: 20,
  offset: const Offset(0, 4),
);

BoxShadow shadow = BoxShadow(
  color: Colors.grey.withOpacity(0.2),
  spreadRadius: 0.4,
  blurRadius: 1,
  offset: const Offset(0, 1),
);
BoxShadow shadowPrimary = const BoxShadow(
  color: primaryColor,
  spreadRadius: 0.8,
  blurRadius: 5,
  offset: Offset(0, 5),
);
ThemeData lightTheme = ThemeData(
  tabBarTheme: const TabBarTheme(
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(
        color: primaryColor,
        width: 2,
      ),
    ),
  ),
  brightness: Brightness.light,
  primaryColor: primaryColor,
  secondaryHeaderColor: colorAccent,
  dividerColor: lightGray,
  fontFamily: 'Poppins',
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      color: Colors.black87,
      fontSize: 12,
    ),
    bodyMedium: TextStyle(
      color: Colors.black87,
      fontSize: 16,
    ),
    bodyLarge: TextStyle(
      color: Colors.black87,
      fontSize: 20,
    ),
    titleLarge: TextStyle(
      fontFamily: "PoppinsBold",
      color: Colors.black87,
      fontSize: 20,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black87,
      fontSize: 16,
    ),
    titleSmall: TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    ),
    headlineSmall: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontSize: 12,
    ),
    headlineMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
    headlineLarge: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    elevation: 0,
  ),
);

ThemeData darkTheme = ThemeData(
  tabBarTheme: const TabBarTheme(
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(
        color: primaryColor,
        width: 2,
      ),
    ),
  ),
  brightness: Brightness.dark,
  primaryColor: primaryColor,
  secondaryHeaderColor: const Color(0xFF1E1E1E),
  dividerColor: const Color(0xFF515151),
  fontFamily: 'Poppins',
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      color: Colors.white,
      fontSize: 12,
    ),
    bodyMedium: TextStyle(
      color: Colors.white,
      fontSize: 16,
    ),
    bodyLarge: TextStyle(
      color: Colors.white,
      fontSize: 20,
    ),
    titleLarge: TextStyle(
      fontFamily: "PoppinsBold",
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
    titleMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
    titleSmall: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    ),
    headlineSmall: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontSize: 12,
    ),
    headlineMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
    headlineLarge: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
  ),
  scaffoldBackgroundColor: const Color(0xFF121212),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF121212),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF121212),
    elevation: 0,
  ),
);
