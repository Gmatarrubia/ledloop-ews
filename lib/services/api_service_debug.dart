import 'dart:io';

final path = Directory.current.path;
File figuresModeJson = File('$path/assets/figures-mode.json');
File figuresMapJson = File('$path/assets/led-map.json');
File workModeJson = File('$path/assets/work-mode.json');

////// Specific functions ////////
Future<String> readFiguresModeFile() async {
  return readJsonFile(figuresModeJson);
}

Future<String> readFiguresMapFile() async {
  return readJsonFile(figuresMapJson);
}

Future<String> readWorkModeFile() async {
  return readJsonFile(workModeJson);
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
