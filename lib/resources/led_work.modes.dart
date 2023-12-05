import 'dart:convert';

class FigureWorkMode {
  String figureName;
  late String stringOn;
  late String stringOff;
  FigureWorkMode(this.figureName) {
    stringOn = setStringOn(figureName);
    stringOff = setStringOff(figureName);
  }

  String setStringOn(String figureName) {
    return '''
{
  "$figureName":
  {
    "mode": "fill",
    "args":
    {
      "r": 100,
      "g": 100,
      "b": 100
    }
  }
}
''';
  }

  String setStringOff(String figureName) {
    return '''
{
  "$figureName":
  {
    "mode": "off"
  }
}
''';
  }
}
