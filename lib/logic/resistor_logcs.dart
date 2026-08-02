import 'package:circuitpedia/models/resistor_model.dart';
import 'package:flutter/material.dart';

class Data {
  static final List<String> resistorNames = [
    "Silver",
    "Gold",
    "Black",
    "Brown",
    "Red",
    "Orange",
    "Yellow",
    "Green",
    "Blue",
    "Violet",
    "Grey",
    "White",
    "None",
  ];
  static final List<Color> resistorColors = [
    const Color(0xFFC0C0C0),
    const Color(0xFFD4AF37),
    const Color(0xFF000000),
    Color(0xFF8B4513),
    const Color(0xFFE53935),
    const Color(0xFFFF9800),
    const Color(0xFFFFEB3B),
    const Color(0xFF4CAF50),
    const Color(0xFF2196F3),
    const Color(0xFF8E24AA),
    const Color(0xFF757575),
    const Color(0xFFFFFFFF),
    Colors.transparent,
  ];
  static final List<double> resistorValues = [0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0];
  static final List<double> resistorPower = [
    0.01,
    0.1,
    1,
    1e1,
    1e2,
    1e3,
    1e4,
    1e5,
    1e6,
    1e7,
    1e8,
    1e9,
    1,
  ];

  static final Map<int, String> resistorPersentage = {
    0: "±10%",
    1: "±5%",
    3: "±1%",
    4: "±2%",
    7: "±0.5%",
    8: "±0.25%",
    9: "±0.1%",
    12: "±20%",
  };

  static final Map<String, double> symbolToUnits = {
    'pΩ': 1e12,
    'nΩ': 1e9,
    'μΩ': 1e6,
    'mΩ': 1e3,
    'Ω': 1,
    'kΩ': 1e3,
    'MΩ': 1e6,
    'GΩ': 1e9,
    'TΩ': 1e12,
  };
  static final Map<String, String> symbolToName = {
    'pΩ': "Pico",
    'nΩ': "Nano",
    'μΩ': "Micro",
    'mΩ': "Milli",
    'Ω': "Ohme",
    'kΩ': "Kilo",
    'MΩ': "Mega",
    'GΩ': "Giga",
    'TΩ': "Tera",
  };
}

class ResistorLogcs {
  ResistorModel colorToValue({
    required ResistorModel resistorModel,
    required List<int> data,
    bool isFour = true,
  }) {
    if (isFour) {
      double value = (Data.resistorValues[data[0]] * 10 + Data.resistorValues[data[1]]);
      double power = Data.resistorPower[data[2]];
      String percentage = Data.resistorPersentage[data[3]] ?? "";
      return resistorModel.copyWith(
        resistor0Index: data[0],
        resistor1Index: data[1],
        resistor2Index: data[2],
        resistor3Index: data[3],
        resultValue: value * power,
        resultsymbol: "Ω",
        resultpercentage: percentage,
      );
    } else {
      double value =
          (Data.resistorValues[data[0]] * 100 +
          (Data.resistorValues[data[1]] * 10) +
          Data.resistorValues[data[2]]);
      double power = Data.resistorPower[data[3]];
      String percentage = Data.resistorPersentage[data[4]] ?? "";
      return resistorModel.copyWith(
        resistor0Index: data[0],
        resistor1Index: data[1],
        resistor2Index: data[2],
        resistor3Index: data[3],
        resistor4Index: data[4],
        resultValue: value * power,
        resultsymbol: "Ω",
        resultpercentage: percentage,
      );
    }
  }

  List<String> _toOhme(String fromValue) {
    List<String> values = fromValue.split(" ");
    switch (values[1]) {
      case "pΩ" || "nΩ" || "μΩ" || "mΩ" || "Ω":
        return ["${double.parse(values[0]) / Data.symbolToUnits[values[1]]!}", "Ω", values[2]];
      case "kΩ" || "MΩ" || "GΩ" || "TΩ":
        return ["${double.parse(values[0]) * Data.symbolToUnits[values[1]]!}", "Ω", values[2]];
    }
    return [];
  }

  String valuesToAlphanumeric(String alphanumeric, String fromValue) {
    if (fromValue.isEmpty) return "Ω";
    List<String> listValues = _toOhme(fromValue);
    double value = double.parse(listValues[0]);
    switch (alphanumeric) {
      case "pΩ" || "nΩ" || "μΩ" || "mΩ" || "Ω":
        return "${value * (Data.symbolToUnits[alphanumeric])!} $alphanumeric ${listValues[2]}";
      case "kΩ" || "MΩ" || "GΩ" || "TΩ":
        return "${value / Data.symbolToUnits[alphanumeric]!} $alphanumeric ${listValues[2]}";
    }
    return "";
  }
}
