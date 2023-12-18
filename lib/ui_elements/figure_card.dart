import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:ews_ledloop/providers/figures_provider.dart';
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
    setState(() {});
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

  Color getColorFromArg(i) {
    if (widget.figure.currentMode.args[i]["type"] == "color") {
      return Color.fromARGB(
          255,
          widget.figure.currentMode.args[i]["r"],
          widget.figure.currentMode.args[i]["g"],
          widget.figure.currentMode.args[i]["b"]);
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

  void changeCardState(FiguresProvider figureProvider, bool currentStatus) {
    figureProvider.setFigureState(widget.figure.name, !currentStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FiguresProvider>(builder: (context, figureProvider, child) {
      bool cardStatus = figureProvider.isFigureEnabled(widget.figure.name);
      return Card(
        color: appTheme.cardTheme.color!,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    widget.figure.name.capitalize(),
                    style: appTheme.textTheme.displayLarge,
                  ),
                  IconButton.filled(
                      icon: Icon(
                        Icons.check_box,
                        color: cardStatus
                            ? Colors.lightGreen
                            : appTheme.shadowColor,
                        size: 23.0,
                      ),
                      onPressed: (() {
                        changeCardState(figureProvider, cardStatus);
                        setState(() {});
                      })),
                ],
              ),
            ),
            DropdownButton<String>(
              style: appTheme.dropdownMenuTheme.textStyle,
              value: widget.figure.currentMode.name,
              isExpanded: true,
              iconSize: 0.0,
              focusColor: appTheme.primaryColor,
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
              height: 50,
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
                        return PickColorButton(
                            enabled: getEnableColorArgs(index),
                            updateState: updateFigureColor,
                            startColor: getColorFromArg(index));
                      }),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
