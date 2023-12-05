import 'dart:convert';

class Mode {
  String name;
  int nargs;
  List<String> args;

  Mode({required this.name, required this.nargs, required this.args});

  factory Mode.fromJson(Map<String, dynamic> json) {
    return Mode(
      name: json['name'],
      nargs: json['nargs'],
      args: List<String>.from(json['args']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'nargs': nargs,
      'args': args,
    };
  }
}

class Figure {
  String name;
  List<Mode> modes;

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
}

class FiguresModel {
  List<Figure> figures;

  FiguresModel({required this.figures});

  factory FiguresModel.fromJson(String jsonStr) {
    Map<String, dynamic> jsonData = json.decode(jsonStr);
    List<dynamic> jsonFigures = jsonData['figures'];
    List<Figure> figures = jsonFigures.map((json) => Figure.fromJson(json)).toList();

    return FiguresModel(figures: figures);
  }

  String toJson() {
    return json.encode({
      'figures': figures.map((figure) => figure.toJson()).toList(),
    });
  }
}