import 'package:flutter/material.dart';

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
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: const MaterialStatePropertyAll<Color>(Colors.amber),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
      onPressed: onTap,
      child: Text(bottonText),
    );
  }
}
