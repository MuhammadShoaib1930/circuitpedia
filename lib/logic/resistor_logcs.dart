import 'dart:math' as math;
import 'dart:math';
import 'package:flutter/material.dart';
import 'resistor_data.dart';

class ResistorLogcs {
  ResistorLogcs._();

  static Color? color(String name) {
    return ResistorData.colors[name];
  }

  static int? digit(String name) {
    return ResistorData.values[name];
  }

  static double? multiplier(String name) {
    return ResistorData.powers[name];
  }

  String? _tolerance(String name) {
    return ResistorData.percentages[name];
  }

  static String? colorFromDigit(int digit) {
    return ResistorData.nameFromValue(digit);
  }

  static String? colorFromMultiplier(double multiplier) {
    return ResistorData.nameFromPower(multiplier);
  }

  static String? colorFromTolerance(String tolerance) {
    return ResistorData.nameFromPercentage(tolerance);
  }

  double _fourBandValue({required String band1, required String band2, required String band3}) {
    final first = digit(band1);
    final second = digit(band2);
    final multiplierValue = multiplier(band3);

    if (first == null || second == null || multiplierValue == null) {
      throw ArgumentError("Invalid resistor color");
    }

    return (first * 10 + second) * multiplierValue;
  }

  // String? fourBandTolerance(String band4) {
  //   return ResistorLogcs._()._tolerance(band4);
  // }

  double _fiveBandValue({
    required String band1,
    required String band2,
    required String band3,
    required String band4,
  }) {
    final first = digit(band1);
    final second = digit(band2);
    final third = digit(band3);
    final multiplierValue = multiplier(band4);

    if (first == null || second == null || third == null || multiplierValue == null) {
      throw ArgumentError("Invalid resistor color");
    }

    return (first * 100 + second * 10 + third) * multiplierValue;
  }

  double _valueFromColors(List<String> bands) {
    if (bands.length == 4) {
      return _fourBandValue(band1: bands[0], band2: bands[1], band3: bands[2]);
    }

    if (bands.length == 5) {
      return _fiveBandValue(band1: bands[0], band2: bands[1], band3: bands[2], band4: bands[3]);
    }

    throw ArgumentError("Resistor must have 4, 5 or 6 bands");
  }

  static String? _toleranceFromColors(List<String> bands) {
    if (bands.length < 4) {
      return null;
    }

    return ResistorLogcs._()._tolerance(bands[bands.length - 1]);
  }

  static Map<String, dynamic> calculateFromColors(List<String> bands) {
    final value = ResistorLogcs._()._valueFromColors(bands);
    final resistorTolerance = _toleranceFromColors(bands);

    return {"value": value, "tolerance": resistorTolerance, "bands": bands};
  }

  static Map<String, dynamic> valueToParts(double value, {int bands = 4}) {
    if (value <= 0) {
      throw ArgumentError("Value must be greater than 0");
    }

    if (bands != 4 && bands != 5) {
      throw ArgumentError("Bands must be 4 or 5");
    }

    final requiredDigits = bands == 4 ? 2 : 3;

    int exponent = 0;
    double normalized = value;

    while (normalized >= math.pow(10, requiredDigits)) {
      normalized /= 10;
      exponent++;
    }

    while (normalized < math.pow(10, requiredDigits - 1)) {
      normalized *= 10;
      exponent--;
    }

    final digits = normalized.round();

    final digitString = digits.toString();

    final digitList = digitString.split('').map(int.parse).toList();

    final multiplierValue = math.pow(10, exponent);

    return {"digits": digitList, "multiplier": multiplierValue.toDouble(), "exponent": exponent};
  }

  static List<String> colorsFromValue(double value, {int bands = 4}) {
    final parts = valueToParts(value, bands: bands);

    final digits = parts["digits"] as List<int>;
    final multiplierValue = (parts["multiplier"]) as double;
    final result = <String>[];
    for (final d in digits) {
      final name = colorFromDigit(d);

      if (name == null) {
        throw ArgumentError("No resistor color for digit $d");
      }

      result.add(name);
    }

    final multiplierColor = colorFromMultiplier(multiplierValue);

    if (multiplierColor == null) {
      throw ArgumentError("No resistor color for multiplier $multiplierValue");
    }

    result.add(multiplierColor);

    return result;
  }

  static List<String> colorsFromValueAndTolerance(
    double value,
    String toleranceValue, {
    int bands = 4,
  }) {
    final colors = colorsFromValue(value, bands: bands);

    final toleranceColor = colorFromTolerance(toleranceValue);

    if (toleranceColor == null) {
      throw ArgumentError("Invalid tolerance: $toleranceValue");
    }

    colors.add(toleranceColor);

    return colors;
  }

  static Map<String, double> toleranceRange({
    required double value,
    required String toleranceValue,
  }) {
    final percent = _percentageNumber(toleranceValue);

    final amount = value * percent / 100;

    return {"minimum": value - amount, "maximum": value + amount};
  }

  static double _percentageNumber(String toleranceValue) {
    final clean = toleranceValue.replaceAll("±", "").replaceAll("%", "");

    final value = double.tryParse(clean);

    if (value == null) {
      throw ArgumentError("Invalid tolerance: $toleranceValue");
    }

    return value;
  }

  static List<String> get allTolerances {
    return ResistorData.percentages.values.toSet().toList();
  }

  static String formatValue(double ohms) {
    if (ohms >= 1e12) {
      return "${_removeZeros(ohms / 1e12)} TΩ";
    }

    if (ohms >= 1e9) {
      return "${_removeZeros(ohms / 1e9)} GΩ";
    }

    if (ohms >= 1e6) {
      return "${_removeZeros(ohms / 1e6)} MΩ";
    }

    if (ohms >= 1e3) {
      return "${_removeZeros(ohms / 1e3)} kΩ";
    }

    if (ohms < 1e-9) {
      return "${_removeZeros(ohms / 1e-12)} pΩ";
    }

    if (ohms < 1e-6) {
      return "${_removeZeros(ohms / 1e-9)} nΩ";
    }

    if (ohms < 1e-3) {
      return "${_removeZeros(ohms / 1e-6)} μΩ";
    }

    if (ohms < 1) {
      return "${_removeZeros(ohms / 1e-3)} mΩ";
    }

    return "${_removeZeros(ohms)} Ω";
  }

  static String _removeZeros(double value) {
    return value.toStringAsFixed(10).replaceFirst(RegExp(r'\.?0+$'), '');
  }
}

class SMDResistorLogic {
  String codeToValue(String code) {
    code = code.trim();
    if (code == "0" || code == "00" || code == "000") {
      return "0 Ω";
    }
    if (code.length <= 2) {
      return "$code Ω";
    } else if (code.length == 3) {
      double firstTwo = double.parse(code.substring(0, 2));
      double multiplier = double.parse(code.substring(2));

      double value = firstTwo * pow(10, multiplier);

      return ResistorLogcs.formatValue(value);
    } else {
      int firstThree = int.parse(code.substring(0, 3));
      int multiplier = int.parse(code.substring(3));

      int value = firstThree * pow(10, multiplier) as int;

      return ResistorLogcs.formatValue(value.toDouble());
    }
  }

  String valueToCode(String value) {
    final parts = value.trim().split(RegExp(r'\s+'));

    if (parts.length <= 2) {
      return value.split(" ")[0];
    }

    double number = double.parse(parts[0]);
    String unit = parts[1];
    double ohms = number * ResistorData.unitFactors[unit]!;
    if (ohms == 0) {
      return "0";
    }

    return generateCode(ohms);
  }

  String generateCode(double ohms) {
    print(ohms);
    for (int multiplier = 0; multiplier <= 9; multiplier++) {
      double significant = ohms / pow(10, multiplier);

      if (significant >= 10 && significant <= 99 && significant == significant.roundToDouble()) {
        return "${significant.toInt()}$multiplier";
      }
    }

    for (int multiplier = 0; multiplier <= 9; multiplier++) {
      double significant = ohms / pow(10, multiplier);

      if (significant >= 100 && significant <= 999 && significant == significant.roundToDouble()) {
        return "${significant.toInt()}$multiplier";
      }
    }

    throw FormatException("Cannot represent $ohms Ω as a standard SMD code");
  }
}
