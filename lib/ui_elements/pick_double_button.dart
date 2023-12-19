import 'package:ews_ledloop/resources/ui_constants.dart';
import 'package:flutter/material.dart';

class PickDoubleButton extends StatefulWidget {
  const PickDoubleButton(
      {super.key, required this.updateState, required this.startValue});

  final Function updateState;
  final double startValue;

  @override
  State<PickDoubleButton> createState() => _PickDoubleButtonState();
}

class _PickDoubleButtonState extends State<PickDoubleButton> {
  late double currentValue = getStartValue();

  double getStartValue() {
    return widget.startValue;
  }

  void valueIncrease(double incease) {
    currentValue = currentValue + incease;
    widget.updateState(currentValue);
    setState(() {});
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: MaterialButton(
        elevation: 10.0,
        height: 75,
        shape: const CircleBorder(side: BorderSide(width: 1.0)),
        color: Colors.blueGrey,
        onPressed: (() {
          doublePickerDialog();
        }),
        child: Container(
          padding: const EdgeInsets.all(2),
          child: Text(
            currentValue.toStringAsFixed(2),
            style: kDisplayMedium,
          ),
        ),
      ),
    );
  }

  Future doublePickerDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.black.withOpacity(0.75),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kCornerRadius)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton.outlined(
                    onPressed: (() {
                      valueIncrease(0.01);
                      setState(() {});
                    }),
                    icon: const Icon(Icons.keyboard_arrow_up),
                    color: appTheme.primaryColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      currentValue.toStringAsFixed(2),
                      style: kDisplayLarge.copyWith(
                        color: appTheme.primaryColorDark,
                      ),
                    ),
                  ),
                  IconButton.outlined(
                    onPressed: (() {
                      valueIncrease(-0.01);
                      setState(() {});
                    }),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    color: appTheme.primaryColor,
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.only(
                          left: 30.0, top: 0.0, right: 30.0, bottom: 0.0)),
                  onPressed: () {
                    widget.updateState(currentValue);
                    Navigator.of(context).pop(false);
                  },
                  child: Text('Cerrar',
                      style: TextStyle(color: appTheme.primaryColorDark)),
                ),
              ],
            );
          });
        });
  }
}
