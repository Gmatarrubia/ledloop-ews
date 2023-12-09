import 'package:flutter/material.dart';

const Color kTextColor = Color.fromARGB(255, 27, 27, 27);
ColorScheme myColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.teal,
  background: Colors.black54,
);

ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  colorScheme: myColorScheme,
  textTheme: const TextTheme(
    titleLarge: TextStyle(
        fontSize: 25, fontFamily: 'nonito-semibold', color: kTextColor),
    displayLarge: TextStyle(
        fontSize: 20, fontFamily: 'nonito-semibold', color: kTextColor),
    displayMedium:
        TextStyle(fontSize: 15, fontFamily: 'nonito', color: kTextColor),
  ),
  appBarTheme: const AppBarTheme(
    //color: inversePrimary,
    backgroundColor: Colors.teal,
    iconTheme: IconThemeData(color: Colors.white),
    centerTitle: true,
    titleTextStyle: TextStyle(
        fontSize: 25, fontFamily: 'nonito-semibold', color: kTextColor),
  ),
  buttonTheme: ButtonThemeData(
    colorScheme: myColorScheme,
    textTheme: ButtonTextTheme.normal,
  ),
  cardTheme: CardTheme(
    color: myColorScheme.primary,
  ),
  dropdownMenuTheme: const DropdownMenuThemeData(
    textStyle: TextStyle(
        fontSize: 15,
        fontFamily: 'nonito',
        color: Colors.white,
    ),
  ),
);

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
