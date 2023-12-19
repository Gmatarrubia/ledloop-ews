import 'package:ews_ledloop/resources/ui_constants.dart';
import 'package:flutter/material.dart';

class PickDoubleButton extends StatefulWidget {
  const PickDoubleButton(
      {super.key,
      required this.enabled,
      required this.updateState,
      required this.startValue});

  final Function updateState;
  final bool enabled;
  final double startValue;

  @override
  State<PickDoubleButton> createState() => _PickDoubleButtonState();
}

class _PickDoubleButtonState extends State<PickDoubleButton> {
  late double selectedValue = getStartValue();
  double currentValue = 0.0;

  double getStartValue() {
    return widget.startValue;
  }

  void changeValue(double value) {
    setState(() {
      selectedValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: MaterialButton(
        elevation: 10.0,
        shape: CircleBorder(
            side: widget.enabled
                ? const BorderSide(width: 1.0)
                : BorderSide.none),
        color: Colors.blueGrey,
        onPressed: widget.enabled
            ? (() {
                doublePickerDialog();
              })
            : null,
        child: Text(currentValue.toString(),
          style: kDisplayMedium,
        ),
      ),
    );
  }

  Future doublePickerDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black.withOpacity(0.75),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kCornerRadius)),
        content: const Column(
          children: [
            IconButton.outlined(onPressed: null, icon: Icon(
              Icons.arrow_circle_up),
            ),
            Text("data"),
            IconButton.outlined(onPressed: null, icon: Icon(
              Icons.arrow_circle_down),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(
                    left: 30.0, top: 0.0, right: 30.0, bottom: 0.0)),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Cerrar', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }
}
