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
    setState(() {});
  }

  void updateFigureSpeed(double value) {
    var (hasSpeed, argPos, speed) = widget.figure.getInfoSpeedArgs();
    String valueString = value.toStringAsFixed(2);
    String newSpeedString = '''
  {
    "type" : "speed",
    "value" : $valueString
  }
''';
    widget.figure.currentMode.args[argPos] = jsonDecode(newSpeedString);
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

  double getSpeedFromArg() {
    var speed = 0.5;
    bool hasSpeed = false;
    int argPos = 0;
    (hasSpeed, argPos, speed) = widget.figure.getInfoSpeedArgs();
    return speed;
  }

  void changeCardState(FiguresProvider figureProvider, bool currentStatus) {
    figureProvider.setFigureState(widget.figure.name, currentStatus);
  }

  @override
  Widget build(BuildContext context) {
    var kCardColor = Colors.white.withAlpha(215);

    return Consumer<FiguresProvider>(builder: (context, figureProvider, child) {
      bool cardStatus = figureProvider.isFigureEnabled(widget.figure.name);
      return Card(
        color: kCardColor,
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
                    style: kDisplayLarge,
                  ),
                  Switch(
                    value: cardStatus,
                    activeColor: appTheme.primaryColorDark,
                    onChanged: (bool value) {
                      changeCardState(figureProvider, value);
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            DropdownButton<String>(
              style: appTheme.dropdownMenuTheme.textStyle,
              value: widget.figure.currentMode.name,
              isExpanded: true,
              iconSize: 0.0,
              focusColor: kCardColor.withOpacity(0.0),
              dropdownColor: appTheme.primaryColorDark.withOpacity(0.95),
              onChanged: ((String? value) => updateActiveFigureMode(value!)),
              items:
                  getModesNames().map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Center(
                    child: Text(value.capitalize()),
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
                      itemCount: widget.figure.getNumberColorsArgs(),
                      itemBuilder: (context, index) {
                        return PickColorButton(
                            index: index,
                            updateState: updateFigureColor,
                            startColor: getColorFromArg(index));
                      }),
                  Visibility(
                    visible: widget.figure.getInfoSpeedArgs().$1,
                    child: PickDoubleButton(
                      updateState: updateFigureSpeed,
                      startValue: getSpeedFromArg(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
