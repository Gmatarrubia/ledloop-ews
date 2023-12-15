import 'package:flutter/material.dart';
import 'package:ews_ledloop/resources/ui_constants.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class PickColorButton extends StatefulWidget {
  const PickColorButton(
      {super.key,
      required this.enabled,
      required this.updateState,
      required this.startColor});

  final Function updateState;
  final bool enabled;
  final Color startColor;

  @override
  State<PickColorButton> createState() => _PickColorButtonState();
}

class _PickColorButtonState extends State<PickColorButton> {
  late Color selectedColor = getStartColor();
  Color currentColor = const Color(0xff443a49);

  Color getStartColor() {
    return widget.startColor;
  }

  void changeColor(Color color) {
    setState(() {
      selectedColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        shape: CircleBorder(
            side: widget.enabled
                ? const BorderSide(width: 1.0)
                : BorderSide.none),
        color: selectedColor,
        onPressed: widget.enabled
            ? (() {
                colorPickerDialog();
              })
            : null,
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
          child: ColorPicker(
            pickerColor: selectedColor,
            onColorChanged: changeColor,
            enableAlpha: false,
            labelTypes: const [],
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
              widget.updateState(selectedColor);
              Navigator.of(context).pop(false);
            },
            child: const Text('Cerrar', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }
}
