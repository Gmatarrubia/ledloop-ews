import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:convert';

String getBaseUrl() {
  if (kIsWeb) {
    return '';
  } else {
    return "http://ideafix.local";
  }
}

class ApiService {
  var client = http.Client();
  static String scriptPath = "/scripts";
  String getConfigScript = "$scriptPath/get-config.py";
  String getInfoScript = "$scriptPath/get-info.py";
  //Todo: Replace the following
  //final final String setScript = "$scriptPath/set-config.py"; //good
  final String setScript = "$scriptPath/comm-ledloop.py";  //bad

  // GET
  Future<dynamic> getConfiguration() async {
    var url = Uri.parse(getBaseUrl() + getConfigScript);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.statusCode.toString();
    }
  }

    Future<String> getInfo() async {
    var url = Uri.parse(getBaseUrl() + getInfoScript);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.statusCode.toString();
    }
  }

  // Post
  Future<dynamic> setConfiguration(String newConfig) async {
    var url = Uri.parse(getBaseUrl() + setScript);
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: newConfig,
      );
    if (response.statusCode == 200) {
      return "Éxito";
    } else {
      return response.statusCode.toString();
    }
  }
}

