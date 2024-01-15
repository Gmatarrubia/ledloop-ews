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
    List<dynamic> colors = [];
    for (final arg in args) {
      int r = arg.red;
      int g = arg.green;
      int b = arg.blue;
      colors.add(json.decode('{"r": $r, "g": $g, "b": $b}'));
    }
    workJson[figureName]['args'] = colors;
    stringWorkMode = json.encode(workJson);
  }

  String setString(String figureName, String mode) {
    return '''
{
  "$figureName":
  {
    "name": "$mode",
    "args":
    {
    }
  }
}
''';
  }
}
