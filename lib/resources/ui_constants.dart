import 'package:flutter/material.dart';

const Color kBackgroundColor = Colors.black;
const Color kCardBackgroundColor = Color(0xFF90A4A3);
const Color kBottomBackgroundColor = Color(0xFF90A4A3);

const Color kTextColor = Color.fromARGB(255, 27, 27, 27);
const int kBoxBackgroundAlpha = 200;

const kTextAppbarStyle = TextStyle(
  fontSize: 25.0,
  fontFamily: 'nonito-semibold',
  color: kTextColor,
);

const kTextCardStyle = TextStyle(
  fontSize: 20.0,
  fontFamily: 'nonito-semibold',
  color: kTextColor,
);

const kTextBottomStyle = TextStyle(
  fontSize: 15.0,
  fontFamily: 'nonito',
  color: kTextColor,
);

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
