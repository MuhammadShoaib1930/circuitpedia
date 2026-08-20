import 'dart:math' as math;
import 'dart:math';
import 'dart:ui';
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

  static List<String> smdUnits() {
    List<String> r = ResistorData.unitFactors.keys.toList();
    r.removeRange(0, 4);
    r.removeLast();

    return r;
  }
}

class SMDResistorLogic {
  String codeToValue(String code) {
    String result = "";
    if (code.contains(".")) {
      result = code;
    } else {
      if (code.length < 3) {
        result = code;
      } else if (code.length == 3) {
        result = (double.parse(code.substring(0, 2)) * pow(10, int.parse(code.substring(2))))
            .toString();
      } else if (code.length == 4) {
        result = (double.parse(code.substring(0, 3)) * pow(10, int.parse(code.substring(3))))
            .toString();
      }
    }
    return "$result Ω";
  }

  String coverPointValues(String value) {
    {
      if (double.parse(value) >= 1) {
        return int.parse(value).toString();
      } else {
        double v = double.parse(value);
        if (v == 0) {
          return "0";
        } else if (v >= 0.001 && v <= 0.999) {
          return v.toString();
        } else {
          return "The compunent not Exist.";
        }
      }
    }
  }

  String convertToOhm(String value, String unit) {
    if ('kΩ' == unit) {
      return (double.parse(value) * 1e3).toInt().toString();
    } else if ('MΩ' == unit) {
      return (double.parse(value) * 1e6).toInt().toString();
    } else if ('GΩ' == unit) {
      return (double.parse(value) * 1e9).toInt().toString();
    } else if ('Ω' == unit) {
      return value;
    }
    return '0';
  }

  String valueToCode(String value, String symbol) {
    String result = "";
    String ohme = convertToOhm(value, symbol);
    if (ohme.contains(".")) {
      if (ohme.length > 5) {
        return ohme.substring(0, 5);
      }
      return ohme;
    } else {
      int n = ohme.toString().length;
      if (n > 2 && n < 12) {
        result += "${ohme.toString().substring(0, 2)}${ohme.toString().substring(2).length}";
      }
      if (n > 3 && n < 13) {
        String s = (result.isEmpty) ? "" : " OR ";
        result += " $s${ohme.toString().substring(0, 3)}${ohme.toString().substring(3).length}";
      }

      if (n > 12) {
        return "The value is not exist.";
      } else if (n < 3) {
        result = ohme.toString();
      }
    }
    return result;
  }
}
