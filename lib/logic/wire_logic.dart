
class WireLogic {
  List<String> headings = [
    "WireGage",
    "Diameter mm",
    "Diameter Inch",
    "Area mm2",
    "Max Ampere",
    "Length per Kilogram (m/kg)",
  ];
  static Map<String, List<dynamic>> filteredList(String value, String heading, dynamic data) {
    switch (heading.toLowerCase()) {
      case ("wiregage"):
        return mapData(wireGage(value, data), data);
      case "diameter mm":
        return mapData(diameterMm(value, data), data);
      case "diameter inch":
        return mapData(diameterInchs(value, data), data);
      case "area mm2":
        return mapData(areaMM2(value, data), data);
      case "max ampere":
        return mapData(maxAmpere(value, data), data);
      case "Length per Kilogram (m/kg)":
        return mapData(lengthMeterPerKg(value, data), data);
      default:
        return mapData([], data);
    }
  }

  static List<int> wireGage(String value, dynamic data) {
    return data.wireGauge
        .asMap()
        .entries
        .where((e) => e.value.startsWith(value))
        .map((e) => e.key)
        .toList();
  }

  static List<int> diameterMm(String value, dynamic data) {
    List<int> indexes = data.diameterMm
        .asMap()
        .entries
        .where((e) => e.value.toString().startsWith(value))
        .map((e) => e.key)
        .toList();
    return indexes;
  }

  static List<int> diameterInchs(String value, dynamic data) {
    List<int> indexes = data.diameterInch
        .asMap()
        .entries
        .where((e) => e.value.toString().startsWith(value))
        .map((e) => e.key)
        .toList();
    return indexes;
  }

  static List<int> areaMM2(String value, dynamic data) {
    List<int> indexes = data.areaMm2
        .asMap()
        .entries
        .where((e) => e.value.toString().startsWith(value))
        .map((e) => e.key)
        .toList();
    return indexes;
  }

  static List<int> maxAmpere(String value, dynamic data) {
    List<int> indexes = data.maxAmpere
        .asMap()
        .entries
        .where((e) => e.value.toString().startsWith(value))
        .map((e) => e.key)
        .toList();
    return indexes;
  }

  static List<int> lengthMeterPerKg(String value, dynamic data) {
    List<int> indexes = data.lengthMeterPerKg
        .asMap()
        .entries
        .where((e) => e.value.toString().startsWith(value))
        .map((e) => e.key)
        .toList();
    return indexes;
  }

  static Map<String, List<dynamic>> mapData(List<int> indexes, dynamic data) {
    List<String> wireGages = [];
    List<double> diameterMMs = [];
    List<double> diameterInchs = [];
    List<double> areaMM2s = [];
    List<double> maxAmperes = [];
    List<double> lengthMeterPerKgs = [];

    for (int index in indexes) {
      wireGages.add(data.wireGauge[index]);
      diameterMMs.add(data.diameterMm[index]);
      diameterInchs.add(data.diameterInch[index]);
      areaMM2s.add(data.areaMm2[index]);
      maxAmperes.add(data.maxAmpere[index]);
      lengthMeterPerKgs.add(data.lengthMeterPerKg[index]);
    }
    return {
      "wireGages": wireGages,
      "diameterMM": diameterMMs,
      "diameterInch": diameterInchs,
      "areaMm2": areaMM2s,
      "maxAmpere": maxAmperes,
      "lengthMeterPerKgs": lengthMeterPerKgs,
    };
  }
}
