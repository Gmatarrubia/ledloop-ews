import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.title});
  final String title;
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool poweron = true;
  final String cgiScriptUrl = 'http://ideafix.local/scripts/comm-ledloop.py';
  String fileName = 'work-mode.json';
  String myText = "";

  void switchLights(poweron) async {
    try {
      final String jsonString;
      if (poweron == true) {
        jsonString = off;
      } else {
        jsonString = on;
      }

      final response = await http.post(
        Uri.parse(cgiScriptUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonString,
      );
      myText = response.body;
      //print(response.body);
      print('JSON file edited successfully.');
    } catch (e) {
      print('Error: $e');
    }
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              onPressed: () {
                setState(() {
                  switchLights(poweron);
                  poweron = !poweron;
                });
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

Future<String> readJsonFile(File file) async {
  if (await file.exists()) {
    return await file.readAsString();
  } else {
    throw Exception("File not found");
  }
}

String textApagar = "Apagar!";
String textEncender = "Endencer!";

String on = '''
{
  "core":
  {
    "mode": "fill",
    "args":
    {
      "r": 100,
      "g": 100,
      "b": 100
    }
  }
}
''';

String off = '''
{
  "core":
  {
    "mode": "off"
  }
}
''';

Map<String, dynamic> parseJson(String jsonString) {
  return json.decode(jsonString);
}

void editJson(Map<String, dynamic> jsonData, String key, dynamic newValue) {
  jsonData[key] = newValue;
}

Future<void> writeJsonFile(File file, String jsonString) async {
  await file.writeAsString(jsonString);
}
