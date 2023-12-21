import 'package:flutter/material.dart';

const Color kTextColor = Color.fromARGB(255, 27, 27, 27);
ColorScheme myColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.orange,
  primary: Colors.orange,
  secondary: const Color.fromARGB(255, 25, 62, 249),
  background: const Color.fromARGB(255, 9, 22, 87),
);

const TextStyle kTitleLarge =
    TextStyle(fontFamily: 'nonito-bold', color: kTextColor);

const TextStyle kDisplayLarge =
    TextStyle(fontSize: 20, fontFamily: 'nonito-semibold', color: kTextColor);

const TextStyle kDisplayMedium =
    TextStyle(fontSize: 15, fontFamily: 'nonito', color: kTextColor);

const TextStyle kDisplaySmall =
    TextStyle(fontSize: 15, fontFamily: 'nonito', color: kTextColor);

const double kCornerRadius = 20.0;

ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  colorScheme: myColorScheme,
  appBarTheme: AppBarTheme(
    //color: inversePrimary,
    backgroundColor: myColorScheme.primary,
    iconTheme: IconThemeData(color: myColorScheme.background),
    centerTitle: true,
    titleTextStyle: const TextStyle(
        fontSize: 25, fontFamily: 'nonito-black', color: kTextColor),
  ),
  buttonTheme: ButtonThemeData(
    colorScheme: myColorScheme.copyWith(
      primary: const Color.fromARGB(255, 25, 62, 249),
    ),
    textTheme: ButtonTextTheme.primary,
  ),
  cardTheme: const CardTheme(
    color: Color(0xffffffff),
    surfaceTintColor: Colors.transparent,
  ),
  dropdownMenuTheme: const DropdownMenuThemeData(
    textStyle: TextStyle(
      fontSize: 18,
      fontFamily: 'nonito',
      color: Colors.black,
    ),
  ),
  iconTheme: IconThemeData(
    color: myColorScheme.background,
    opacity: 0.85,
  ),
);

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
