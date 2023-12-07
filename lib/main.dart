import 'package:flutter/material.dart';
import 'package:ews_ledloop/screens/main_screen.dart';
import 'package:ews_ledloop/resources/ui_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const String title = "Ledloop Control";
    return MaterialApp(
      title: title,
      theme: appTheme,
      home: const MainScreen(title: title),
    );
  }
}
