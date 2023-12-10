import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ews_ledloop/services/api_service.dart';
import 'package:ews_ledloop/resources/led_work.modes.dart';
import 'package:ews_ledloop/model/figures.dart';
import 'package:ews_ledloop/ui_elements/pick_color_button.dart';
import 'package:ews_ledloop/resources/ui_constants.dart';

class FigureCard extends StatefulWidget {
  const FigureCard({super.key, required this.figure, required this.api});
  final Figure figure;
  final ApiService api;
  @override
  State<FigureCard> createState() => _FigureCardState();
}

class _FigureCardState extends State<FigureCard> {
  String activeFigureMode = "off";
  List<Color> colorsOfMode = [Colors.black, Colors.black, Colors.black];
  int localNargs = 0;

  List<String> getModesNames() {
    List<String> modeNames = [];
    for (final mode in widget.figure.modes) {
      modeNames.add(mode.name);
    }
    return modeNames;
  }

  Future<String> getCurrentMode() async {
    Map<String, dynamic> currentWork =
        json.decode(await widget.api.getConfiguration());
    return await currentWork[widget.figure.name]["mode"];
  }

  void updateActiveFigureMode(String newMode) async {
    await widget.api.setConfiguration(
        FigureWorkMode(widget.figure.name, newMode, colorsOfMode)
            .stringWorkMode);
    setState(() {
      activeFigureMode = newMode;
      for (final mode in widget.figure.modes) {
        if (mode.name == activeFigureMode) {
          localNargs = mode.nargs;
        }
      }
    });
  }

  void updateFigureColor(Color newColor) async {
    List<Color> activeArgs = [];
    //for (int i = 0; i < localNargs; i++) {
    //  activeArgs.add(colorsOfMode[i]);
    //}
    colorsOfMode[0] = newColor;
    activeArgs.add(newColor);
    await widget.api.setConfiguration(
        FigureWorkMode(widget.figure.name, activeFigureMode, activeArgs)
            .stringWorkMode);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: appTheme.cardTheme.color!,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            child: Text(
              widget.figure.name.capitalize(),
              style: appTheme.textTheme.displayLarge,
            ),
          ),
          FutureBuilder(
              future: getCurrentMode(),
              builder: (context, AsyncSnapshot<String> currentMode) {
                if (currentMode.connectionState == ConnectionState.waiting) {
                  return const Text("Cargando..");
                } else {
                  return DropdownButton<String>(
                    style: appTheme.dropdownMenuTheme.textStyle,
                    value: currentMode.data,
                    isExpanded: true,
                    onChanged: ((String? value) =>
                        updateActiveFigureMode(value!)),
                    items: getModesNames()
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Center(
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                  );
                }
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PickColorButton(
                  enabled: localNargs > 0,
                  updateState: updateFigureColor,
                  startColor: colorsOfMode[0]),
              PickColorButton(
                  enabled: localNargs > 1,
                  updateState: updateFigureColor,
                  startColor: colorsOfMode[1]),
              PickColorButton(
                  enabled: localNargs > 2,
                  updateState: updateFigureColor,
                  startColor: colorsOfMode[2]),
            ],
          ),
        ],
      ),
    );
  }
}
