import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ews_ledloop/services/api_service.dart';
import 'package:ews_ledloop/ui_elements/figure_card.dart';
import 'package:ews_ledloop/resources/ui_constants.dart';
import 'package:ews_ledloop/providers/figures_provider.dart';

class FiguresView extends StatefulWidget {
  const FiguresView({super.key});

  @override
  State<FiguresView> createState() => _FiguresViewState();
}

class _FiguresViewState extends State<FiguresView> {
  final ApiService api = ApiService();

  @override
  Widget build(BuildContext context) {
    return Consumer<FiguresProvider>(builder: (context, figureProvider, child) {
      if (figureProvider.figureModel.figures.isEmpty) {
        return const Center(
          child: SizedBox(
            height: 150,
            width: 150,
            child: CircularProgressIndicator(
              strokeWidth: 10.0,
              backgroundColor: Colors.black54,
              color: Colors.tealAccent,
            ),
          ),
        );
      } else {
        return Container(
          color: appTheme.colorScheme.background,
          child: Stack(
            alignment: Alignment.bottomCenter,
            fit: StackFit.loose,
            textDirection: TextDirection.ltr,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: figureProvider.figureModel.figures.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3.0, horizontal: 12.0),
                            alignment: Alignment.center,
                            child: FigureCard(
                              figure: figureProvider.figureModel.figures[index],
                              api: api,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              ApplyBottom(
                api: api,
                bottonAction: (() {
                  String model2Send = figureProvider.getModel2Send();
                  print(model2Send);
                  api.setFigureConfig(model2Send);
                  return;
                }),
              ),
            ],
          ),
        );
      }
    });
  }
}

class ApplyBottom extends StatelessWidget {
  const ApplyBottom({
    super.key,
    required this.bottonAction,
    required this.api,
  });

  final VoidCallback bottonAction;
  final ApiService api;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 50.0,
      color: Colors.lightGreen,
      onPressed: bottonAction,
      child: const Text("Aplicar"),
    );
  }
}
