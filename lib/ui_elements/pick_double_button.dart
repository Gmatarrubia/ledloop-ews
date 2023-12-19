import 'dart:async';

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
  Timer? timer;

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
        height: 46.0,
        shape: const CircleBorder(side: BorderSide(width: 1.0)),
        color: appTheme.primaryColor,
        onPressed: (() {
          doublePickerDialog();
        }),
        child: Container(
          padding: const EdgeInsets.all(2),
          child: Text(
            currentValue.toStringAsFixed(2),
            style: kDisplayMedium.copyWith(
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
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
              backgroundColor: Colors.white.withOpacity(0.90),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kCornerRadius)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTapDown: ((details) {
                      timer = Timer.periodic(const Duration(milliseconds: 100),
                          (timer) {
                        setState(() {
                          valueIncrease(0.01);
                        });
                      });
                    }),
                    onTapUp: (details) {
                      // Stop the timer when the button is released
                      timer?.cancel();
                    },
                    onTapCancel: () {
                      // Stop the timer if the button press is canceled
                      timer?.cancel();
                    },
                    child: Icon(
                      Icons.keyboard_arrow_up_outlined,
                      color: appTheme.primaryColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      currentValue.toStringAsFixed(2),
                      style: kDisplayLarge,
                    ),
                  ),
                  InkWell(
                    onTapDown: ((details) {
                      timer = Timer.periodic(const Duration(milliseconds: 100),
                          (timer) {
                        setState(() {
                          valueIncrease(-0.01);
                        });
                      });
                    }),
                    onTapUp: (details) {
                      // Stop the timer when the button is released
                      timer?.cancel();
                    },
                    onTapCancel: () {
                      // Stop the timer if the button press is canceled
                      timer?.cancel();
                    },
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: appTheme.primaryColor,
                    ),
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
                  child: const Text('Cerrar', style: kDisplayLarge),
                ),
              ],
            );
          });
        });
  }
  @override
  void dispose() {
    // Dispose the timer to prevent memory leaks
    timer?.cancel();
    super.dispose();
  }
}
