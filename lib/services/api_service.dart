import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:convert';

String get_base_url() {
  if (kIsWeb) {
    return '';
  } else {
    return "http://ideafix.local";
  }
}

class ApiService {
  var client = http.Client();
  static String scriptPath = "/scripts";
  final String setScript = "$scriptPath/setConfigScript.py";
  //Todo: Replace the following
  //final String getScript = scriptPath + "/getConfigScript.py"; //good
  final String getScript = "$scriptPath/comm-ledloop.py";  //bad

  // GET
  Future<dynamic> getConfiguration() async {
    var url = Uri.parse(get_base_url() + getScript);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      return "Éxito";
    } else {
      return response.body;
    }
  }

  // Post
  Future<dynamic> setConfiguration(String newConfig) async {
    var url = Uri.parse(get_base_url() + getScript);
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

