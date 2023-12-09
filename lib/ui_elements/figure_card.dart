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

  Future<String> switchOnLights() async {
    var response = await widget.api
        .setConfiguration(FigureWorkMode(widget.figure.name).stringOn);
    return response;
  }

  Future<String> switchOffLights() async {
    var response = await widget.api
        .setConfiguration(FigureWorkMode(widget.figure.name).stringOff);
    return response;
  }

  List<String> getModesNames() {
    List<String> modeNames = [];
    for (final mode in widget.figure.modes) {
      modeNames.add(mode.name);
    }
    return modeNames;
  }

  void getCurrentMode() async {
    var currentWork = await widget.api.getConfiguration();
    activeFigureMode = currentWork[widget.figure.name];
  }

  void updateActiveFigureMode(String newMode) {
    setState(() {
      activeFigureMode = newMode;
    });
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
            value: activeFigureMode,
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PickColorButton(enabled: true),
              PickColorButton(enabled: false),
              PickColorButton(enabled: false),
            ],
          ),
        ],
      ),
    );
  }
}
