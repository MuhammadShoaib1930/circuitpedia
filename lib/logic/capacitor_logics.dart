import 'dart:math';

class CapacitorLogics {
  static const Map<String, double> units = {"pF": 1, "nF": 1e3, "µF": 1e6, "mF": 1e9, "F": 1e12};

  String codeToValue(String code) {
    if (code.length < 3) {
      return "$code pF";
    }

    final base = double.parse(code.substring(0, 2));
    final exponent = int.parse(code[2]);

    final value = base * pow(10, exponent);

    return formatValue(value);
  }

  String valueToCode(String value) {
    final parts = value.split(" ");

    final digits = double.parse(parts[0]);
    final unit = parts[1];

    final pF = digits * units[unit]!;

    if (pF < 10) {
      return pF.toInt().toString();
    }

    final exponent = pF.toInt().toString().length - 2;
    final base = pF / pow(10, exponent);

    return "${base.toInt()}$exponent";
  }

  String formatValue(double pF) {
    if (pF >= units["F"]!) {
      return "${pF / units["F"]!} F";
    }

    if (pF >= units["mF"]!) {
      return "${pF / units["mF"]!} mF";
    }

    if (pF >= units["µF"]!) {
      return "${pF / units["µF"]!} µF";
    }

    if (pF >= units["nF"]!) {
      return "${pF / units["nF"]!} nF";
    }

    return "$pF pF";
  }

  List<String> convert(String value) {
    final parts = value.split(" ");

    final digits = double.parse(parts[0]);
    final symbol = parts[1];

    final pF = digits * units[symbol]!;

    return units.keys.map((unit) {
      final result = pF / units[unit]!;
      return "$result $unit";
    }).toList();
  }
}
