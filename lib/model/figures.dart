import 'dart:convert';

class Mode {
  String name;
  List<dynamic> args;

  Mode({required this.name, required this.args});

  factory Mode.fromJson(Map<String, dynamic> json) {
    return Mode(
      name: json['name'],
      args: List<dynamic>.from(json['args']),
    );
  }
  factory Mode.disabled() {
    return Mode(name: "off", args: []);
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'args': args,
    };
  }
}

class Figure {
  String name;
  List<Mode> modes;
  Mode currentMode =
      Mode.fromJson(jsonDecode('{"name":"off", "args":[]}'));

  Figure({required this.name, required this.modes});

  factory Figure.fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonModes = json['modes'];
    List<Mode> modes = jsonModes.map((json) => Mode.fromJson(json)).toList();

    return Figure(
      name: json['name'],
      modes: modes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'modes': modes.map((mode) => mode.toJson()).toList(),
    };
  }

  int getNumberColorsArgs() {
    int num = 0;
    for (final arg in currentMode.args) {
      if (arg["type"] == "color") {
        num++;
      }
    }
    return num;
  }

  (bool, int, double) getInfoSpeedArgs() {
    bool hasSpeedArg = false;
    int pos = 0;
    double value = 0.0;
    for (final arg in currentMode.args) {
      if (arg["type"] == "speed") {
        hasSpeedArg = true;
        value = arg["value"];
        break;
      }
      pos++;
    }
    return (hasSpeedArg, pos, value);
  }
}

class FiguresModel {
  List<Figure> figures;

  FiguresModel({required this.figures});

  factory FiguresModel.fromJson(String jsonStr) {
    Map<String, dynamic> jsonData = json.decode(jsonStr);
    List<dynamic> jsonFigures = jsonData['figures'];
    List<Figure> figures =
        jsonFigures.map((json) => Figure.fromJson(json)).toList();

    return FiguresModel(figures: figures);
  }

  String toJson() {
    return json.encode({
      'figures': figures.map((figure) => figure.toJson()).toList(),
    });
  }

  void setCurrentModes(workModeJson, enableFigureModel) {
    Map<String, dynamic> workMode = json.decode(workModeJson);
    for (final figure in figures) {
      if (workMode.containsKey(figure.name)) {
        figure.currentMode = Mode.fromJson(workMode[figure.name]);
        enableFigureModel[figure.name] = true;
      } else {
        figure.currentMode = Mode.disabled();
        enableFigureModel[figure.name] = false;
      }
    }
  }
}
