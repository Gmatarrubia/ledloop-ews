import 'package:flutter/material.dart';
import 'package:ews_ledloop/resources/led_work.modes.dart';
import 'package:ews_ledloop/services/api_service.dart';
import 'package:ews_ledloop/ui_elements/work_mode_botton.dart';
import 'package:ews_ledloop/model/figures.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.title});
  final String title;
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool poweron = true;
  String myText = "";
  String bottomText = "Switch leds";
  final ApiService api = ApiService();
  late FiguresModel figuresModel;

  Future<String> switchLights(poweron) async {
    if (poweron == true) {
      myText = await api.setConfiguration(off);
    } else {
      myText = await api.setConfiguration(on);
    }
    return myText;
  }

  Future<String> getState() async {
    figuresModel = FiguresModel.fromJson( await api.getInfo());
    return "Switch leds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            WorkModeBotton(
              bottonText: bottomText,
              onTap: () async {
                myText = await switchLights(poweron);
                bottomText = await getState();
                poweron = !poweron;
                setState(() {});
              },
            ),
            Text(myText)
          ],
        ),
      ),
    );
  }
}
