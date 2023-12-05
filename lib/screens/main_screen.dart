import 'package:ews_ledloop/resources/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:ews_ledloop/ui_elements/figures_view.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title,
          style: kTextCardStyle,
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: FiguresView(),
      ),
    );
  }
}
