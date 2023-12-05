import 'package:flutter/material.dart';
import 'package:ews_ledloop/services/api_service.dart';
import 'package:ews_ledloop/resources/led_work.modes.dart';
import 'package:ews_ledloop/model/figures.dart';
import 'package:ews_ledloop/ui_elements/work_mode_botton.dart';

class FigureCard extends StatefulWidget {
  const FigureCard({super.key, required this.figure, required this.api});
  final Figure figure;
  final ApiService api;
  @override
  State<FigureCard> createState() => _FigureCardState();
}

class _FigureCardState extends State<FigureCard> {
  Future<String> switchOnLights() async {
    var response = await widget.api.setConfiguration(
      FigureWorkMode(widget.figure.name).stringOn);
    return response;
  }

  Future<String> switchOffLights() async {

    var response = await widget.api.setConfiguration(
      FigureWorkMode(widget.figure.name).stringOff);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    String bottomResponse = "";
    return Card(
      color: Colors.tealAccent,
      child: Column(
        children: [
          Text(widget.figure.name),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WorkModeBotton(
                bottonText: "Encender",
                onTap: () async {
                  bottomResponse = await switchOnLights();
                  setState(() {});
                },
              ),
              const SizedBox(
                width: 20,
                height: 40,
              ),
              WorkModeBotton(
                bottonText: "Apagar",
                onTap: () async {
                  bottomResponse = await switchOffLights();
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
