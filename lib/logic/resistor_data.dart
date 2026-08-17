import 'package:flutter/material.dart';

class ResistorData {
  static const Map<String, Color> colors = {
    "Silver": Color(0xFFC0C0C0),
    "Gold": Color(0xFFD4AF37),
    "Black": Color(0xFF000000),
    "Brown": Color(0xFF8B4513),
    "Red": Color(0xFFE53935),
    "Orange": Color(0xFFFF9800),
    "Yellow": Color(0xFFFFEB3B),
    "Green": Color(0xFF4CAF50),
    "Blue": Color(0xFF2196F3),
    "Violet": Color(0xFF8E24AA),
    "Grey": Color(0xFF757575),
    "White": Color(0xFFFFFFFF),
    "None": Colors.transparent,
  };
  static const Map<String, int> values = {
    "Black": 0,
    "Brown": 1,
    "Red": 2,
    "Orange": 3,
    "Yellow": 4,
    "Green": 5,
    "Blue": 6,
    "Violet": 7,
    "Grey": 8,
    "White": 9,
    "None": 0,
  };

  static const Map<String, double> powers = {
    "Silver": 0.01,
    "Gold": 0.1,
    "Black": 1,
    "Brown": 1e1,
    "Red": 1e2,
    "Orange": 1e3,
    "Yellow": 1e4,
    "Green": 1e5,
    "Blue": 1e6,
    "Violet": 1e7,
    "Grey": 1e8,
    "White": 1e9,
    "None": 1,
  };

  static const Map<String, String> percentages = {
    "Silver": "±10%",
    "Gold": "±5%",
    "Brown": "±1%",
    "Red": "±2%",
    "Green": "±0.5%",
    "Blue": "±0.25%",
    "Violet": "±0.1%",
    "None": "±20%",
  };

  static String? nameFromValue(int value) {
    for (final entry in values.entries) {
      if (entry.value == value) {
        return entry.key;
      }
    }
    return null;
  }

  static String? nameFromPower(double power) {
    for (final entry in powers.entries) {
      if (entry.value == power) {
        return entry.key;
      }
    }
    return null;
  }

  static String? nameFromPercentage(String percentage) {
    for (final entry in percentages.entries) {
      if (entry.value == percentage) {
        return entry.key;
      }
    }
    return null;
  }

  static const Map<String, double> unitFactors = {
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

  static const Map<String, String> unitNames = {
    'pΩ': "Pico",
    'nΩ': "Nano",
    'μΩ': "Micro",
    'mΩ': "Milli",
    'Ω': "Ohm",
    'kΩ': "Kilo",
    'MΩ': "Mega",
    'GΩ': "Giga",
    'TΩ': "Tera",
  };
}
