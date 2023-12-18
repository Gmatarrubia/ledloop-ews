import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:ews_ledloop/services/api_service_debug.dart';

// Set true for offline API calls.
const bool kDebugOffLine = false;

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
  final String setScript = "$scriptPath/set-config.py";
  final String setFigureScript = "$scriptPath/comm-ledloop.py";

  // GET
  Future<dynamic> getConfiguration() async {
    // Return offline if kDebugOffLine is true
    if (kDebugOffLine) {
      return readWorkModeFile();
    }

    var url = Uri.parse(getBaseUrl() + getConfigScript);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.statusCode.toString();
    }
  }

  Future<String> getInfo() async {
    //Return offline if kDebugOffLine is true
    if (kDebugOffLine) {
      return readFiguresModeFile();
    }

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
    //Return offline if kDebugOffLine is true
    if (kDebugOffLine) {
      writeWorkModeFile(newConfig);
      return "Éxito";
    }

    var url = Uri.parse(getBaseUrl() + setScript);
    var response = await http.post(
      url,
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

  Future<dynamic> setFigureConfig(String newConfig) async {
    //Return offline if kDebugOffLine is true
    if (kDebugOffLine) {
      writeWorkModeFile(newConfig);
      return "Éxito";
    }

    var url = Uri.parse(getBaseUrl() + setFigureScript);
    var response = await http.post(
      url,
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
