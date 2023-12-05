import 'package:flutter/material.dart';
import 'package:ews_ledloop/services/api_service.dart';
import 'package:ews_ledloop/ui_elements/figure_card.dart';
import 'package:ews_ledloop/model/figures.dart';
import 'package:flutter/rendering.dart';

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
    int i = 2;
    return FutureBuilder(
        future: getState(),
        builder: (context, AsyncSnapshot<FiguresModel> figuresModel) {
          if (figuresModel.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (figuresModel.hasError) {
            return Center(
              child: Text('Error: ${figuresModel.error}'),
            );
          } else {
            FiguresModel myFiguresModel = figuresModel.data!;
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 2,
                    itemBuilder: (context, i) {
                      return const ListTile(
                        title: SizedBox(
                            height: 50, width: 50, child: Text("Hola")),
                      );
                    },
                  ),
                  Text(myText)
                ],
              ),
            );
          }
        });
  }
}
