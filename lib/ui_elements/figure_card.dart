import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ews_ledloop/services/api_service.dart';
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
    for (final mode in widget.figure.modes) {
      if (mode.name == newMode) {
        widget.figure.currentMode = mode;
      }
    }
    setState(() {
     });
  }

  void updateFigureColor(Color newColor) async {
    int r = newColor.red, g = newColor.green, b = newColor.blue;
    String newColorString = '''
[
  {
    "type" : "color",
    "r" : $r,
    "g" : $g,
    "b" : $b
  }
]''';
    widget.figure.currentMode.args = jsonDecode(newColorString);
    setState(() {});
  }

  Color getColorFromArg(num) {
    if (widget.figure.currentMode.args[num]["type"] == "color") {
      return Color.fromARGB(
          255,
          widget.figure.currentMode.args[num]["r"],
          widget.figure.currentMode.args[num]["g"],
          widget.figure.currentMode.args[num]["b"]);
    } else {
      return const Color.fromARGB(0, 0, 0, 0);
    }
  }

  bool getEnableColorArgs(index) {
    var len = 0;
    for (final arg in widget.figure.currentMode.args) {
      if (arg["type"] == "color") {
        len++;
      }
    }
    return index < len ? true : false;
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
          DropdownButton<String>(
            style: appTheme.dropdownMenuTheme.textStyle,
            value: widget.figure.currentMode.name,
            isExpanded: true,
            onChanged: ((String? value) => updateActiveFigureMode(value!)),
            items:
                getModesNames().map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Center(
                  child: Text(value),
                ),
              );
            }).toList(),
          ),
          SizedBox(
            height: 100,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: widget.figure.currentMode.args.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: PickColorButton(
                            enabled: getEnableColorArgs(index),
                            updateState: updateFigureColor,
                            startColor: getColorFromArg(index)),
                      );
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
