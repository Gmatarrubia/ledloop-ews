import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ews_ledloop/model/figures.dart';
import 'package:ews_ledloop/services/api_service.dart';

class FiguresProvider with ChangeNotifier {
  FiguresModel figureModel = FiguresModel.fromJson('{"figures":[]}');

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
  }

  Future getCurrentModes() async {
    var api = ApiService();
    figureModel.setCurrentModes(await api.getConfiguration());
  }

  String getModel2Send() {
    Map<String, dynamic> myModel2Send = {};
    for (final figure in figureModel.figures) {
      myModel2Send[figure.name] = figure.currentMode;
    }
    return jsonEncode(myModel2Send);
  }
}
