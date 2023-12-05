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
  String myText = "";
  final ApiService api = ApiService();

  Future<FiguresModel> getState() async {
    return FiguresModel.fromJson(await api.getInfo());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: FutureBuilder(
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
              FiguresModel myFiguresModel = figuresModel.data!;
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
                            padding: const EdgeInsets.all(12),
                            alignment: Alignment.center,
                            child: FigureCard(
                              figure: myFiguresModel.figures[index],
                              api: api,
                            ),
                          );
                        },
                      ),
                      Text(myText)
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}
