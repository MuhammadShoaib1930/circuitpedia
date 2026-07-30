import 'package:flutter/material.dart';

class ResistorData {
  final Color color;
  final int value;
  final double power;
  final double persentage;
  ResistorData({
    required this.color,
    required this.value,
    required this.power,
    required this.persentage,
  });
}

class ResistorLogcs {
  final Map<String, ResistorData> colorsValue = {
    "Silver": ResistorData(
      color: const Color(0xFFC0C0C0),
      value: 0,
      power: 0.01,
      persentage: 10,
    ),
    "Gold": ResistorData(
      color: const Color(0xFFD4AF37),
      value: 0,
      power: 0.1,
      persentage: 5,
    ),
    "Black": ResistorData(
      color: const Color(0xFF000000),
      value: 0,
      power: 1,
      persentage: 0,
    ),
    "Brown": ResistorData(
      color: const Color(0xFF8B4513),
      value: 1,
      power: 10,
      persentage: 1,
    ),
    "Red": ResistorData(
      color: const Color(0xFFE53935),
      value: 2,
      power: 100,
      persentage: 2,
    ),
    "Orange": ResistorData(
      color: const Color(0xFFFF9800),
      value: 3,
      power: 1000,
      persentage: 0,
    ),
    "Yellow": ResistorData(
      color: const Color(0xFFFFEB3B),
      value: 4,
      power: 10000,
      persentage: 0,
    ),
    "Green": ResistorData(
      color: const Color(0xFF4CAF50),
      value: 5,
      power: 100000,
      persentage: 0.5,
    ),
    "Blue": ResistorData(
      color: const Color(0xFF2196F3),
      value: 6,
      power: 1000000,
      persentage: 0.55,
    ),
    "Violet": ResistorData(
      color: const Color(0xFF8E24AA),
      value: 7,
      power: 10000000,
      persentage: 0.1,
    ),
    "Grey": ResistorData(
      color: const Color(0xFF757575),
      value: 8,
      power: 100000000,
      persentage: 0,
    ),
    "White": ResistorData(
      color: const Color(0xFFFFFFFF),
      value: 9,
      power: 1000000000,
      persentage: 0,
    ),
    "None": ResistorData(
      color: Colors.transparent,
      value: 0,
      power: 1,
      persentage: 20,
    ),
  };
  final Map<String, double> ohmFactors = {
    'pΩ': 1e-12,
    'nΩ': 1e-9,
    'μΩ': 1e-6,
    'mΩ': 1e-3,
    'Ω': 1,
    'kΩ': 1e3,
    'MΩ': 1e6,
    'GΩ': 1e9,
    'TΩ': 1e12,
  };
  final Map<String, String> symbolToName = {
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
  Color getColor(String name) {
    return colorsValue[name]!.color;
  }

  String calculated({required List<String> names, bool isfourColuors = true}) {
    if (isfourColuors) {
      double value1 = colorsValue[names[0]]!.value.toDouble();
      double value2 = colorsValue[names[1]]!.value.toDouble();
      double power3 = colorsValue[names[2]]!.power.toDouble();
      double persentage4 = colorsValue[names[3]]!.persentage.toDouble();
      return ("${(value1 * 10 + value2) * power3} Ω ±$persentage4%");
    } else {
      double value1 = colorsValue[names[0]]!.value.toDouble();
      double value2 = colorsValue[names[1]]!.value.toDouble();
      double value3 = colorsValue[names[2]]!.value.toDouble();
      double power4 = colorsValue[names[3]]!.power.toDouble();
      double persentage5 = colorsValue[names[4]]!.persentage.toDouble();
      return ("${(value1 * 100 + (value2 * 10) + value3) * power4} Ω ±$persentage5%");
    }
  }

  List<String> _toOhme(String fromValue) {
    List<String> values = fromValue.split(" ");
    return [
      "${double.parse(values[0]) * ohmFactors[values[1]]!}",
      "Ω",
      values[2],
    ];
  }

  String valuesToAlphanumeric(String alphanumeric, String fromValue) {
    if(fromValue.isEmpty)return "Ω";
    List<String> listValues = _toOhme(fromValue);
    double value = double.parse(listValues[0]);
    switch (alphanumeric) {
      // case "pΩ" || "nΩ" || "μΩ" || "mΩ" || "Ω":
      case 'pΩ':
      case 'nΩ':
      case 'μΩ':
      case 'mΩ':
      case 'Ω':
        return "${value * ohmFactors[alphanumeric]!} pΩ ${listValues[2]}";
      // case "kΩ" || "MΩ" || "GΩ" || "TΩ":
      case 'kΩ':
      case 'MΩ':
      case 'GΩ':
      case 'TΩ':
        return "${value / ohmFactors[alphanumeric]!} kΩ ${listValues[2]}";
    }
    return "";
  }
}
