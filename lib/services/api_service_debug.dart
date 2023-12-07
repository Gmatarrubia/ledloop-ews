import 'dart:convert';
import 'dart:io';

final path = Directory.current.path;
File figuresModeJson = File('$path/assets/figures-mode.json');
File workModeJson = File('$path/assets/work-mode.json');

////// Specifict functions ////////
Future<String> readFiguresModeFile() async {
  return readJsonFile(figuresModeJson);
}

void writeWorkModeFile(String jsonData) async {
  await writeJsonFile(workModeJson, jsonData);
}

////// Low leven functions ////////
Future<String> readJsonFile(File file) async {
  if (await file.exists()) {
    return await file.readAsString();
  } else {
    throw Exception("File not found");
  }
}

Future<void> writeJsonFile(File file, String jsonString) async {
  await file.writeAsString(jsonString);
}
