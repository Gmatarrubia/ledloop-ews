import 'package:flutter/material.dart';
import 'package:ews_ledloop/resources/led_work.modes.dart';
import 'package:ews_ledloop/services/api_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.title});
  final String title;
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool poweron = true;
  String myText = "";
  final ApiService api = ApiService();

  Future<String> switchLights(poweron) async {
    if (poweron == true) {
      myText = await api.setConfiguration(off);
    } else {
      myText = await api.setConfiguration(on);
    }
    return myText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    const MaterialStatePropertyAll<Color>(Colors.amber),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              onPressed: () async {
                myText = await switchLights(poweron);
                poweron = !poweron;
                setState(() {});
              },
              child: Text(poweron ? textApagar : textEncender),
            ),
            Text(myText)
          ],
        ),
      ),
    );
  }
}
