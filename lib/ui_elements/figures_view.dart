import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ews_ledloop/services/api_service.dart';
import 'package:ews_ledloop/ui_elements/figure_card.dart';
import 'package:ews_ledloop/resources/ui_constants.dart';
import 'package:ews_ledloop/providers/figures_provider.dart';
import 'package:ews_ledloop/ui_elements/apply_button.dart';
import 'package:ews_ledloop/ui_elements/quick_actions_button.dart';

class FiguresView extends StatelessWidget {
  FiguresView({super.key});

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
              color: Colors.orangeAccent,
            ),
          ),
        );
      } else {
        return Stack(
          alignment: Alignment.bottomCenter,
          fit: StackFit.loose,
          textDirection: TextDirection.ltr,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 30.0),
                alignment: Alignment.center,
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const AlwaysScrollableScrollPhysics(),
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
                ),
              ),
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: QuickActionsButton(
                    api: api,
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: ApplyButton(
                    buttonAction: (() {
                      String model2Send = figureProvider.getModel2Send();
                      print(model2Send);
                      api.setConfiguration(model2Send);
                    }),
                  ),
                ),
              ],
            ),
          ],
        );
      }
    });
  }
}
