import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:ews_ledloop/resources/ui_constants.dart';
import 'package:ews_ledloop/ui_elements/figures_view.dart';
import 'package:ews_ledloop/providers/figures_provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        titleTextStyle: appTheme.appBarTheme.titleTextStyle,
        centerTitle: true,
      ),
      body: Center(
        child: ChangeNotifierProvider<FiguresProvider>(
          create: (context) => FiguresProvider(),
          child: FiguresView(),
        )
      ),
    );
  }
}
