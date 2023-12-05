import 'package:flutter/material.dart';
import 'package:ews_ledloop/resources/ui_constants.dart';

class WorkModeBotton extends StatelessWidget {
  const WorkModeBotton({
    super.key,
    required this.bottonText,
    required this.onTap,
  });

  final String bottonText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: const MaterialStatePropertyAll<Color>(Colors.amber),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        onPressed: onTap,
        child: Text(
          bottonText.capitalize(),
          style: kTextBottomStyle,
        ),
      ),
    );
  }
}
