import 'dart:convert';

class Mode {
  String name;
  int nargs;
  var args = List.empty();

  Mode({required this.name, required this.nargs, required this.args});

  factory Mode.fromJson(Map<String, dynamic> json) {
    return Mode(
      name: json['name'],
      nargs: json['nargs'].toInt(),
      args: json['args'],
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
  List<Mode> modes = List.empty();

  Figure({required this.name, required this.modes});

  factory Figure.fromJson(Map<String, dynamic> json) {
    return Figure(name: json[0], modes: json[1]);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'modes': modes,
    };
  }
}

class FiguresModel {
  List<Figure> figures;

  FiguresModel({required this.figures});

  factory FiguresModel.fromJson(String jsonStr) {
    Map<String, dynamic> jsonMap = json.decode(jsonStr);
    List<Figure> figures = jsonMap.forEach((key, value) {
      var myMap = Map<String, dynamic>();
      myMap[key] = value;
      return Figure.fromJson(myMap);
    });
    return FiguresModel(figures: figures);
  }

  String toJson() {
    List<Map<String, dynamic>> jsonList =
        figures.map((figure) => figure.toJson()).toList();
    return json.encode(jsonList);
  }
}
