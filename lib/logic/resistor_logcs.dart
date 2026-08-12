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
    int index = -1,
    int position = -1,
    bool isFour = true,
    String symbol = "Ω",
  }) {
    List<int> data = [
      resistorModel.resistor0Index,
      resistorModel.resistor1Index,
      resistorModel.resistor2Index,
      resistorModel.resistor3Index,
    ];
    if (position != -1 && index != -1) {
      data[position] = index;
    }
    if (isFour) {
      double result =
          (Data.resistorValues[data[0]] * 10 + Data.resistorValues[data[1]]) *
          Data.resistorPower[data[2]];
      if (symbol == "pΩ" || symbol == "nΩ" || symbol == "μΩ" || symbol == "mΩ") {
        result *= Data.symbolToUnits[symbol]!;
      } else if (symbol == "kΩ" || symbol == "MΩ" || symbol == "GΩ" || symbol == "TΩ") {
        result /= Data.symbolToUnits[symbol]!;
      }
      String percentage = Data.resistorPersentage[data[3]] ?? "";
      return resistorModel.copyWith(
        resistor0Index: data[0],
        resistor1Index: data[1],
        resistor2Index: data[2],
        resistor3Index: data[3],
        resultValue: result,
        resultsymbol: symbol,
        resultpercentage: percentage,
      );
    } else {
      double result =
          (Data.resistorValues[data[0]] * 100 +
              (Data.resistorValues[data[1]] * 10) +
              Data.resistorValues[data[2]]) *
          Data.resistorPower[data[3]];
      String percentage = Data.resistorPersentage[data[4]] ?? "";

      if (symbol == "pΩ" || symbol == "nΩ" || symbol == "μΩ" || symbol == "mΩ") {
        result *= Data.symbolToUnits[symbol]!;
      } else if (symbol == "kΩ" || symbol == "MΩ" || symbol == "GΩ" || symbol == "TΩ") {
        result /= Data.symbolToUnits[symbol]!;
      }
      return resistorModel.copyWith(
        resistor0Index: data[0],
        resistor1Index: data[1],
        resistor2Index: data[2],
        resistor3Index: data[3],
        resistor4Index: data[4],
        resultValue: result,
        resultsymbol: symbol,
        resultpercentage: percentage,
      );
    }
  }

  double _percentageToDouble(String percentage) {
    return double.parse(percentage.replaceAll(RegExp(r'[±%]'), ""));
  }

  (double, double) getMinMax(double value, String percentage) {
    double tolerance = value * (_percentageToDouble(percentage) / 100);
    return (value - tolerance, value + tolerance);
  }

  int getValue(List<double> values, double value) {
    for (int i = 0; i < values.length; i++) {
      if (values[i] == value) {
        return i;
      }
    }
    return -1;
  }

  void valueToColors({required double value, required bool isFour, required ResistorModel model}) {
    if (isFour) {
      // 0.0 to 9.9
      if (value >= 0.0 && value <= 9.9) {
        value = double.parse(value.toString().replaceAll('.', ''))*10;
      }
      double minV = 0, maxV = 0;
      (minV, maxV) = getMinMax(value, model.resultpercentage);
      double digits = double.parse("1e${value.toInt().toString().substring(2).length}");
      double r1 = (int.parse((minV).toString()[0]) * 10 + int.parse((minV).toString()[1])) * digits;
      double r2 = (int.parse((maxV).toString()[0]) * 10 + int.parse((maxV).toString()[1])) * digits;
      double result = 0;
      if (r1 >= minV && r1 <= maxV) {
        result = r1;
      } else {
        result = r2;
      }
      ResistorModel newModel = model.copyWith(
        resistor0Index: getValue(Data.resistorValues, double.parse(result.toString()[0])),
        resistor1Index: getValue(Data.resistorValues, double.parse(result.toString()[1])),
        resistor3Index: getValue(Data.resistorPower, double.parse(result.toString()[2])),
      );
      print(newModel);
    } else {}
  }
}
