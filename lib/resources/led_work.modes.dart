import 'package:flutter/material.dart';
import 'dart:convert';

class FigureWorkMode {
  String figureName;
  String mode;
  late String stringWorkMode;
  List<Color> args;

  FigureWorkMode(this.figureName, this.mode, this.args) {
    stringWorkMode = setString(figureName, mode);
    Map<String, dynamic> workJson = json.decode(stringWorkMode);
    //only working for fill
    //for (final arg in args) {
    int r = args[0].red;
    int g = args[0].green;
    int b = args[0].blue;
    String color = '{"r": $r, "g": $g, "b": $b}';
    workJson[figureName]['args'] = json.decode(color);
    stringWorkMode = json.encode(workJson);
  }

  String setString(String figureName, String mode) {
    return '''
{
  "$figureName":
  {
    "mode": "$mode",
    "args":
    {
    }
  }
}
''';
  }
}
