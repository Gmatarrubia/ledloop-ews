import 'package:flutter/material.dart';
import 'package:ews_ledloop/resources/ui_constants.dart';

class ApplyButton extends StatelessWidget {
  const ApplyButton({
    super.key,
    required this.buttonAction,
  });

  final VoidCallback buttonAction;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.all(8.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(kCornerRadius)
      )),
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
