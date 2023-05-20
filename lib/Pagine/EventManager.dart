import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:registro/Pagine/Eventi.dart';

class EventiManager {
  final String fileName = 'eventi.json';

  Future<Map<DateTime, List<Eventi>>> loadEvents() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');

    if (file.existsSync()) {
      final jsonString = await file.readAsString();
      final jsonMap = json.decode(jsonString);

      final loadedEvents = Map<DateTime, List<Eventi>>.fromEntries(
        jsonMap.entries.map(
              (entry) => MapEntry(
            DateTime.parse(entry.key),
            List<Eventi>.from(
              entry.value.map((item) => Eventi.fromJson(item)),
            ),
          ),
        ),
      );

      return loadedEvents;
    }

    return {};
  }

  Future<void> saveEvents(Map<DateTime, List<Eventi>> events) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');

    final jsonMap = events.map(
          (key, value) => MapEntry(key.toString(), value.map((item) => item.toJson()).toList()),
    );
    final jsonString = json.encode(jsonMap);

    await file.writeAsString(jsonString);
  }
}