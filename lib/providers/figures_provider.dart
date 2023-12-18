import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ews_ledloop/model/figures.dart';
import 'package:ews_ledloop/services/api_service.dart';

class FiguresProvider with ChangeNotifier {
  FiguresModel figureModel = FiguresModel.fromJson('{"figures":[]}');
  Map<String, bool> enableFigureModel = {};
  FiguresProvider() {
    initState();
  }

  void initState() async {
    await getEnabledFigures();
    await getCurrentModes();
    notifyListeners();
  }

  Future getEnabledFigures() async {
    var api = ApiService();
    figureModel = FiguresModel.fromJson(await api.getInfo());
    //Enable all figures by default
    for (final figure in figureModel.figures) {
      enableFigureModel[figure.name] = false;
    }
  }

  Future getCurrentModes() async {
    var api = ApiService();
    figureModel.setCurrentModes(await api.getConfiguration(), enableFigureModel);
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
    enableFigureModel[figureName] = status;
    notifyListeners();
  }
}
