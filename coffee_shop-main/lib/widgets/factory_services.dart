import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<List<List<String>>?> loadCoffeeOptions() async {
  String jsonString =
      await rootBundle.loadString('catalog/coffee_options.json');
  Map<String, dynamic> jsonData = json.decode(jsonString);
  List<List<String>> optionsList = (jsonData['optionsList'] as List)
      .map((list) => List<String>.from(list))
      .toList();

  return optionsList;
}
