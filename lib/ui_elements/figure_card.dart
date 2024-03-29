import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:ews_ledloop/providers/figures_provider.dart';
import 'package:ews_ledloop/services/api_service.dart';
import 'package:ews_ledloop/model/figures.dart';
import 'package:ews_ledloop/ui_elements/pick_color_button.dart';
import 'package:ews_ledloop/ui_elements/pick_double_button.dart';
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

  void updateFigureColor(int index, Color newColor) {
    int r = newColor.red, g = newColor.green, b = newColor.blue;
    String newColorString = '''
  {
    "type" : "color",
    "r" : $r,
    "g" : $g,
    "b" : $b
  }
''';
    widget.figure.currentMode.args[index] = jsonDecode(newColorString);
  }

  void updateFigureDouble(int index, double value) {
    DoubleArg myDoubleArg = getDoubleFromArg(index);
    String name = myDoubleArg.name;
    String valueString = value.toStringAsFixed(2);
    String deltaString = myDoubleArg.delta.toStringAsFixed(2);
    String minString = myDoubleArg.min.toStringAsFixed(2);
    String maxString = myDoubleArg.max.toStringAsFixed(2);
    String newDoubleString = '''
  {
    "type" : "double",
    "name" : "$name",
    "value" : $valueString,
    "delta": $deltaString,
    "min": $minString,
    "max": $maxString
  }
''';
    widget.figure.currentMode.args[index] = jsonDecode(newDoubleString);
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

  DoubleArg getDoubleFromArg(int i) {
    if (widget.figure.currentMode.args[i]["type"] == "double") {
      return DoubleArg(
          name: widget.figure.currentMode.args[i]["name"],
          value: widget.figure.currentMode.args[i]["value"],
          delta: widget.figure.currentMode.args[i]["delta"],
          min: widget.figure.currentMode.args[i]["min"],
          max: widget.figure.currentMode.args[i]["max"]);
    } else {
      return DoubleArg(name: "  ", value: 0.0, delta: 0.0, min: 0.0, max: 1.0);
    }
  }

  DoubleArg getInitialDoubleArg(int index) {
    var positionArgs = getDoubleFromArg(index);
    for (final mode in widget.figure.modes) {
      if (mode.name == widget.figure.currentMode.name) {
        widget.figure.currentMode.args[index] = mode.args[index];
        return DoubleArg(
            name: mode.args[index]["name"],
            value: mode.args[index]["value"],
            delta: mode.args[index]["delta"],
            min: mode.args[index]["min"],
            max: mode.args[index]["max"]);
      }
    }
    return positionArgs;
  }

  void changeCardState(FiguresProvider figureProvider, bool currentStatus) {
    figureProvider.setFigureState(widget.figure.name, currentStatus);
  }

  @override
  Widget build(BuildContext context) {
    var kCardColor = const Color(0xffffffff);
    return Consumer<FiguresProvider>(builder: (context, figureProvider, child) {
      bool cardStatus = figureProvider.isFigureEnabled(widget.figure.name);
      return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                    style: kDisplayLarge,
                  ),
                  Switch(
                    value: cardStatus,
                    inactiveTrackColor: Colors.white,
                    activeColor: appTheme.primaryColorDark,
                    onChanged: (bool value) {
                      changeCardState(figureProvider, value);
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            Visibility(
              visible: cardStatus,
              child: DropdownButton<String>(
                style: appTheme.dropdownMenuTheme.textStyle,
                value: widget.figure.currentMode.name,
                isExpanded: true,
                iconSize: 0.0,
                focusColor: kCardColor.withOpacity(0.0),
                dropdownColor: kCardColor,
                borderRadius: BorderRadius.circular(kCornerRadius),
                onChanged: ((String? value) => updateActiveFigureMode(value!)),
                items: getModesNames()
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Center(
                      child: Text(value.capitalize()),
                    ),
                  );
                }).toList(),
              ),
            ),
            Visibility(
              visible: cardStatus,
              child: SizedBox(
                height: widget.figure.currentMode.args.isEmpty ? 30 : 85,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: widget.figure.getNumberTypeArgs("color"),
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              PickColorButton(
                                  index: index,
                                  updateState: updateFigureColor,
                                  startColor: getColorFromArg(index)),
                              Text(
                                "Color $index",
                                style: kDisplaySmall,
                              ),
                            ],
                          );
                        }),
                    ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: widget.figure.getNumberTypeArgs("double"),
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              PickDoubleButton(
                                index: index +
                                    widget.figure.getNumberTypeArgs("color"),
                                updateState: updateFigureDouble,
                                arg: getInitialDoubleArg(index +
                                    widget.figure.getNumberTypeArgs("color")),
                              ),
                              Text(
                                getDoubleFromArg(index +
                                        widget.figure
                                            .getNumberTypeArgs("color"))
                                    .name
                                    .capitalize(),
                                style: kDisplaySmall,
                              ),
                            ],
                          );
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
