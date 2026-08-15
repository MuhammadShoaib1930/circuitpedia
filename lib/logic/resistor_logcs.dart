import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'resistor_data.dart';

class ResistorLogcs {
  ResistorLogcs._();

  // ============================================================
  // COLOR → INFORMATION
  // ============================================================

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

  // ============================================================
  // INFORMATION → COLOR
  // ============================================================

  static String? colorFromDigit(int digit) {
    return ResistorData.nameFromValue(digit);
  }

  static String? colorFromMultiplier(double multiplier) {
    return ResistorData.nameFromPower(multiplier);
  }

  static String? colorFromTolerance(String tolerance) {
    return ResistorData.nameFromPercentage(tolerance);
  }

  static String? colorFromColor(Color color) {
    return ResistorData.nameFromColor(color);
  }

  // ============================================================
  // 4-BAND RESISTOR
  //
  // Band 1 = first digit
  // Band 2 = second digit
  // Band 3 = multiplier
  // Band 4 = tolerance
  //
  // Example:
  // Brown - Black - Red - Gold
  // 1 0 × 100 = 1000Ω ±5%
  // ============================================================

  double _fourBandValue({required String band1, required String band2, required String band3}) {
    final first = digit(band1);
    final second = digit(band2);
    final multiplierValue = multiplier(band3);

    if (first == null || second == null || multiplierValue == null) {
      throw ArgumentError("Invalid resistor color");
    }

    return (first * 10 + second) * multiplierValue;
  }

  String? _fourBandTolerance(String band4) {
    return ResistorLogcs._()._tolerance(band4);
  }

  // ============================================================
  // 5-BAND RESISTOR
  //
  // Band 1 = first digit
  // Band 2 = second digit
  // Band 3 = third digit
  // Band 4 = multiplier
  // Band 5 = tolerance
  //
  // Example:
  // Brown - Black - Black - Red - Gold
  //
  // 100 × 100 = 10000Ω ±5%
  // ============================================================

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

  String? _fiveBandTolerance(String band5) {
    return ResistorLogcs._()._tolerance(band5);
  }
  // ============================================================
  // COLORS → COMPLETE RESISTOR VALUE
  // ============================================================

  double _valueFromColors(List<String> bands) {
    if (bands.length == 4) {
      return _fourBandValue(band1: bands[0], band2: bands[1], band3: bands[2]);
    }

    if (bands.length == 5) {
      return _fiveBandValue(band1: bands[0], band2: bands[1], band3: bands[2], band4: bands[3]);
    }

    throw ArgumentError("Resistor must have 4, 5 or 6 bands");
  }

  // ============================================================
  // COLORS → TOLERANCE
  // ============================================================

  static String? _toleranceFromColors(List<String> bands) {
    if (bands.length < 4) {
      return null;
    }

    return ResistorLogcs._()._tolerance(bands[bands.length - 1]);
  }

  // ============================================================
  // COLORS → COMPLETE RESULT
  // ============================================================

  static Map<String, dynamic> calculateFromColors(List<String> bands) {
    final value = ResistorLogcs._()._valueFromColors(bands);
    final resistorTolerance = _toleranceFromColors(bands);

    return {"value": value, "tolerance": resistorTolerance, "bands": bands};
  }

  // ============================================================
  // RESISTOR VALUE → DIGITS
  // ============================================================

  static List<int> digitsFromValue(double value) {
    if (value <= 0) {
      throw ArgumentError("Value must be greater than 0");
    }

    final text = value.toString();

    final parts = text.split('.');

    final integerPart = parts[0];
    final decimalPart = parts.length > 1 ? parts[1] : "";

    final digits = [
      ...integerPart.split('').map(int.parse),
      ...decimalPart.split('').map(int.parse),
    ];

    while (digits.length > 1 && digits.last == 0) {
      digits.removeLast();
    }

    return digits;
  }

  // ============================================================
  // VALUE → MULTIPLIER
  //
  // Example:
  //
  // 1000Ω
  // → digits 10
  // → multiplier 100
  // → colors Brown Black Red
  // ============================================================

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

    return {"digits": digitList, "multiplier": multiplierValue, "exponent": exponent};
  }

  // ============================================================
  // VALUE → COLORS
  //
  // Example:
  //
  // 1000Ω
  //
  // → Brown
  // → Black
  // → Red
  // ============================================================

  static List<String> colorsFromValue(double value, {int bands = 4}) {
    final parts = valueToParts(value, bands: bands);

    final digits = parts["digits"] as List<int>;
    final multiplierValue = parts["multiplier"] as double;

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

  // ============================================================
  // VALUE + TOLERANCE → COLORS
  // ============================================================

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

  // ============================================================
  // RESISTOR RANGE FROM TOLERANCE
  // ============================================================

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

  // ============================================================
  // CHECK VALID RESISTOR COLOR
  // ============================================================

  static bool isValidColor(String name) {
    return ResistorData.colors.containsKey(name);
  }

  // ============================================================
  // CHECK VALID DIGIT
  // ============================================================

  static bool isValidDigit(int value) {
    return value >= 0 && value <= 9;
  }

  // ============================================================
  // CHECK VALID TOLERANCE
  // ============================================================

  static bool isValidTolerance(String value) {
    return ResistorData.percentages.containsValue(value);
  }

  // ============================================================
  // ALL COLOR NAMES
  // ============================================================

  static List<String> get allColors {
    return ResistorData.colors.keys.toList();
  }

  // ============================================================
  // ALL TOLERANCES
  // ============================================================

  static List<String> get allTolerances {
    return ResistorData.percentages.values.toSet().toList();
  }

  // ============================================================
  // OHM UNIT CONVERSION
  // ============================================================

  static double convertUnit({required double value, required String from, required String to}) {
    final fromFactor = ResistorData.unitFactors[from];

    final toFactor = ResistorData.unitFactors[to];

    if (fromFactor == null || toFactor == null) {
      throw ArgumentError("Invalid unit");
    }

    final ohms = value * fromFactor;

    return ohms / toFactor;
  }

  // ============================================================
  // OHMS → UNIT
  // ============================================================

  static double toUnit({required double ohms, required String unit}) {
    final factor = ResistorData.unitFactors[unit];

    if (factor == null) {
      throw ArgumentError("Invalid unit: $unit");
    }

    return ohms / factor;
  }

  // ============================================================
  // UNIT → OHMS
  // ============================================================

  static double fromUnit({required double value, required String unit}) {
    final factor = ResistorData.unitFactors[unit];

    if (factor == null) {
      throw ArgumentError("Invalid unit: $unit");
    }

    return value * factor;
  }

  // ============================================================
  // FORMAT RESISTOR VALUE
  // ============================================================

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
