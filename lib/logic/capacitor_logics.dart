class CapacitorLogics {
  String codeToPF(String code) {
    if (code.length < 3) return code;
    double digit = double.parse("${code[0]}${code[1]}");
    int digit3 = int.parse(code[2]);
    while (digit3 > 0) {
      digit *= 10;
      digit3 -= 1;
    }
    return formatValue(digit);
  }

  String pfToCode(String pf) {
    if (pf.length < 3) return pf;
    return (int.parse("${pf[0]}${pf[1]}") * 10 + pf.substring(2).length).toString();
  }

  String formatValue(double value) {
    double v = (value / 1e12);
    if (v * 1e9 > 0.5) {
      return "${v * 1e9} nf";
    } else if (v * 1e6 > 0.5) {
      return "${v * 1e6} uf";
    } else if (v * 1e3 > 0.5) {
      return "${v * 1e3} mf";
    } else if (v * 1e3 > 0.5) {
      return "${v * 1e3} F";
    } else {
      return value.toString();
    }
  }

  static const Map<String, double> units = {"pF": 1e12, "nF": 1e9, "µF": 1e6, "mF": 1e3, "F": 1};

  List<String> convert(String value) {
    final d = value.split(" ");

    final digits = double.parse(d[0]);
    final symbol = d[1];

    final fromFactor = units[symbol];

    if (fromFactor == null) {
      throw Exception("Unknown capacitor unit: $symbol");
    }

    return units.keys.map((unit) {
      final result = (digits / fromFactor) * units[unit]!;
      return "$result $unit";
    }).toList();
  }
}
