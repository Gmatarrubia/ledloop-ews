import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ews_ledloop/model/figures.dart';
import 'package:ews_ledloop/services/api_service.dart';

class FiguresProvider with ChangeNotifier {
  FiguresModel figureModel = FiguresModel.fromJson('{"figures":[]}');
  Map<String, bool> enableFigureModel = {};
  Map<String, dynamic> figureMap = {};
  Map<String, List<String>> incompats = {};
  FiguresProvider() {
    initState();
  }

  void initState() async {
    await getFigures();
    await getCurrentModes();
    await getMap();
    getIncompatibilites();
    notifyListeners();
  }

  Future getFigures() async {
    var api = ApiService();
    figureModel = FiguresModel.fromJson(await api.getInfo());
    //Enable all figures by default
    for (final figure in figureModel.figures) {
      enableFigureModel[figure.name] = false;
    }
  }

  Future getCurrentModes() async {
    var api = ApiService();
    figureModel.setCurrentModes(
        await api.getConfiguration(), enableFigureModel);
  }

  Future getMap() async {
    var api = ApiService();
    for (final figure in jsonDecode(await api.getMap())["figures"]) {
      figureMap[figure["name"]] = [];
      for (final line in figure["ledLinesList"]) {
        var auxPixel = line['pixel'];
        var auxFirst = line['first'];
        var auxLast = line['last'];
        figureMap[figure["name"]].add("$auxFirst:$auxPixel");
        figureMap[figure["name"]].add("$auxLast:$auxPixel");
      }
    }
  }

  void getIncompatibilites() {
    figureMap.forEach((figure, limit1) {
      incompats[figure] = [];
      figureMap.forEach((figure2, limit2) {
        for (final limit in limit1) {
          if (limit2.contains(limit) && figure != figure2) {
            incompats[figure]?.add(figure2);
            break;
          }
        }
      });
    });
  }

  String getModel2Send() {
    Map<String, dynamic> myModel2Send = {};
    for (final figure in figureModel.figures) {
      if (enableFigureModel[figure.name]!) {
        myModel2Send[figure.name] = figure.currentMode;
      }
    }
    return jsonEncode(myModel2Send);
  }

  bool isFigureEnabled(figureName) {
    return enableFigureModel[figureName]!;
  }

  void setFigureState(figureName, status) {
    if (status) {
      for (final figure in figureModel.figures) {
        if (incompats[figureName]!.contains(figure.name)) {
          enableFigureModel[figure.name] = false;
        }
      }
    }
    enableFigureModel[figureName] = status;
    notifyListeners();
  }
}
