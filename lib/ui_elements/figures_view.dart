import 'package:flutter/material.dart';
import 'package:ews_ledloop/services/api_service.dart';
import 'package:ews_ledloop/ui_elements/figure_card.dart';
import 'package:ews_ledloop/model/figures.dart';
import 'package:ews_ledloop/resources/ui_constants.dart';

class FiguresView extends StatefulWidget {
  const FiguresView({super.key});

  @override
  State<FiguresView> createState() => _FiguresViewState();
}

class _FiguresViewState extends State<FiguresView> {
  final ApiService api = ApiService();

  Future<FiguresModel> getState() async {
    return FiguresModel.fromJson(await api.getInfo());
  }

  FiguresModel myFiguresModel = FiguresModel.fromJson('{"figures":[]}');
  @override
  Widget build(BuildContext context) {
    return Container(
      color: appTheme.colorScheme.background,
      child: Stack(
        alignment: Alignment.bottomCenter,
        fit: StackFit.loose,
        textDirection: TextDirection.ltr,
        children: [
          FutureBuilder(
              future: getState(),
              builder: (context, AsyncSnapshot<FiguresModel> figuresModel) {
                if (figuresModel.connectionState == ConnectionState.waiting) {
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
                } else if (figuresModel.hasError) {
                  return Center(
                    child: Text('Error: ${figuresModel.error}'),
                  );
                } else {
                  myFiguresModel = figuresModel.data!;
                  return Center(
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
                            itemCount: myFiguresModel.figures.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 3.0, horizontal: 12.0),
                                alignment: Alignment.center,
                                child: FigureCard(
                                  figure: myFiguresModel.figures[index],
                                  api: api,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }
              }),
          ApplyBottom(
            api: api,
            bottonAction: (() {
              if (myFiguresModel.figures.isEmpty) {
                return;
              }
              //TODO create a FiguresModel with current data from cards
              //avoid that cards send data to the api
              //api.setFigureConfig(myFiguresModel.toJson());
              return;
            }),
          ),
        ],
      ),
    );
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
