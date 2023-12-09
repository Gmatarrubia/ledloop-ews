import 'package:flutter/material.dart';
import 'package:ews_ledloop/resources/ui_constants.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class PickColorButton extends StatefulWidget {
  const PickColorButton({
    super.key,
    required this.enabled,
  });

  final bool enabled;

  @override
  State<PickColorButton> createState() => _PickColorButtonState();
}

class _PickColorButtonState extends State<PickColorButton> {
  Color selectedColor = const Color(0xff2196f3);

  Color currentColor = const Color(0xff443a49);

  void changeColor(Color color) {
    setState(() => selectedColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith((states) {
            return selectedColor;
          }),
          shape: MaterialStateProperty.all<CircleBorder>(
            const CircleBorder(side: BorderSide(width: 1.0),
            ),
          ),
        ),
        onPressed: (() {
          colorPickerDialog();
          }),
        child: const Text(""),
      ),
    );
  }

  Future colorPickerDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: selectedColor,
            onColorChanged: changeColor,
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0)),
                padding: const EdgeInsets.only(
                    left: 30.0, top: 0.0, right: 30.0, bottom: 0.0)),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('CLOSE', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }
}


