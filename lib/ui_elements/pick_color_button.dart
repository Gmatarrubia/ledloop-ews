import 'package:ews_ledloop/resources/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class PickColorButton extends StatefulWidget {
  const PickColorButton(
      {super.key,
      required this.updateState,
      required this.startColor,
      required this.index});

  final Function updateState;
  final Color startColor;
  final int index;

  @override
  State<PickColorButton> createState() => _PickColorButtonState();
}

class _PickColorButtonState extends State<PickColorButton> {
  late Color selectedColor = getStartColor();
  Color currentColor = const Color(0x00000000);

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
      padding: const EdgeInsets.all(5.0),
      child: MaterialButton(
        height: 46.0,
        elevation: 10.0,
        shape: const CircleBorder(side: BorderSide(width: 1.0)),
        color: selectedColor,
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
        backgroundColor: Colors.white.withOpacity(0.90),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kCornerRadius)),
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
              widget.updateState(widget.index, selectedColor);
              Navigator.of(context).pop(false);
            },
            child: const Text('Cerrar', style: kDisplayMedium),
          ),
        ],
      ),
    );
  }
}
