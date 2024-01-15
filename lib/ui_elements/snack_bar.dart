import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ews_ledloop/resources/ui_constants.dart';

void showSnackBar(BuildContext context, String snackText) {
  final snackBar = SnackBar(
    backgroundColor: appTheme.primaryColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(kCornerRadius),
        topRight: Radius.circular(kCornerRadius),
      ),
    ),
    content: SizedBox(
      height: 48.0,
      width: double.infinity,
      child: Center(
        child: Text(
          snackText,
          style: kDisplayLarge,
          textAlign: TextAlign.center,
        ),
      ),
    ),
    duration: const Duration(seconds: 2),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}