import 'package:flutter/material.dart';
import 'package:ews_ledloop/services/api_service.dart';
import 'package:ews_ledloop/resources/ui_constants.dart';

class ApplyButton extends StatelessWidget {
  const ApplyButton({
    super.key,
    required this.buttonAction,
    required this.api,
  });

  final VoidCallback buttonAction;
  final ApiService api;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kCornerRadius)),
      minWidth: double.infinity,
      height: 70.0,
      color: appTheme.primaryColorDark,
      onPressed: buttonAction,
      child: const Text(
        "Aplicar",
        style: kDisplayLarge,
      ),
    );
  }
}
