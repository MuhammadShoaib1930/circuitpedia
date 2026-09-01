import 'package:circuitpedia/logic/copper_wire_data.dart';

class WireLogic {
  static Map<String, List<dynamic>> filteredList(String value, String heading) {
    switch (heading.toLowerCase()) {
      case ("wiregage"):
        return mapData(wireGage(value));
      case "diameter mm":
        return mapData(diameterMm(value));
      case "diameter inch":
        return mapData(diameterInchs(value));
      case "area mm2":
        return mapData(areaMM2(value));
      case "max ampere":
        return mapData(maxAmpere(value));
      case "lengthmeterperkg":
        return mapData(lengthMeterPerKg(value));
      default:
        return mapData([]);
    }
  }

  static List<int> wireGage(String value) {
    return CopperWireData().wireGauge
        .asMap()
        .entries
        .where((e) => e.value.startsWith(value))
        .map((e) => e.key)
        .toList();
  }

  static List<int> diameterMm(String value) {
    List<int> indexes = CopperWireData().diameterMm
        .asMap()
        .entries
        .where((e) => e.value.toString().startsWith(value))
        .map((e) => e.key)
        .toList();
    return indexes;
  }

  static List<int> diameterInchs(String value) {
    List<int> indexes = CopperWireData().diameterInch
        .asMap()
        .entries
        .where((e) => e.value.toString().startsWith(value))
        .map((e) => e.key)
        .toList();
    return indexes;
  }

  static List<int> areaMM2(String value) {
    List<int> indexes = CopperWireData().areaMm2
        .asMap()
        .entries
        .where((e) => e.value.toString().startsWith(value))
        .map((e) => e.key)
        .toList();
    return indexes;
  }

  static List<int> maxAmpere(String value) {
    List<int> indexes = CopperWireData().maxAmpere
        .asMap()
        .entries
        .where((e) => e.value.toString().startsWith(value))
        .map((e) => e.key)
        .toList();
    return indexes;
  }

  static List<int> lengthMeterPerKg(String value) {
    List<int> indexes = CopperWireData().lengthMeterPerKg
        .asMap()
        .entries
        .where((e) => e.value.toString().startsWith(value))
        .map((e) => e.key)
        .toList();
    return indexes;
  }

  static Map<String, List<dynamic>> mapData(List<int> indexes) {
    List<String> wireGages = [];
    List<double> diameterMMs = [];
    List<double> diameterInchs = [];
    List<double> areaMM2s = [];
    List<double> maxAmperes = [];
    List<double> lengthMeterPerKgs = [];
    CopperWireData d = CopperWireData();
    for (int index in indexes) {
      wireGages.add(d.wireGauge[index]);
      diameterMMs.add(d.diameterMm[index]);
      diameterInchs.add(d.diameterInch[index]);
      areaMM2s.add(d.areaMm2[index]);
      maxAmperes.add(d.maxAmpere[index]);
      lengthMeterPerKgs.add(d.lengthMeterPerKg[index]);
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
