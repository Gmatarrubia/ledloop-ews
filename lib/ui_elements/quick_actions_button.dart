import 'package:flutter/material.dart';
import 'package:ews_ledloop/services/api_service.dart';
import 'package:ews_ledloop/resources/ui_constants.dart';
import 'package:ews_ledloop/resources/led_work.modes.dart';

class QuickActionsButton extends StatelessWidget {
  const QuickActionsButton({
    super.key,
    required this.api,
  });

  final ApiService api;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.all(8.0),
      shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.only(topLeft: Radius.circular(kCornerRadius))),
      minWidth: double.infinity,
      height: 70.0,
      color: appTheme.primaryColor,
      onPressed: () {
        _displayBottomSheet(context);
      },
      child: const Icon(
        color: kTextColor,
        Icons.flash_on,
      ),
    );
  }

  Future _displayBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      constraints: const BoxConstraints.expand(height: 100.0),
      backgroundColor: appTheme.primaryColor,
      showDragHandle: false,
      context: context,
      builder: (BuildContext context) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: ListTile(
                title: const Icon(color: kTextColor, Icons.power_settings_new),
                onTap: () {
                  FigureWorkMode model2Send =
                      FigureWorkMode("complete", "off", []);
                  print(model2Send.stringWorkMode);
                  api.setConfiguration(model2Send.stringWorkMode);
                  Navigator.pop(context);
                },
              ),
            ),
            Flexible(
              flex: 1,
              child: ListTile(
                title: const Icon(color: kTextColor, Icons.lightbulb),
                onTap: () {
                  const List<Color> warmWhite = [Color.fromARGB(255, 200, 255, 147)];
                  FigureWorkMode model2Send = FigureWorkMode(
                    "complete",
                    "fill",
                    warmWhite
                  );
                  print(model2Send.stringWorkMode);
                  api.setConfiguration(model2Send.stringWorkMode);
                  Navigator.pop(context);
                },
              ),
            ),
            Flexible(
              flex: 1,
              child: ListTile(
                title: const Icon(color: kTextColor, Icons.undo),
                onTap: () {
                  api.sendRestoreLastModeAction();
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
