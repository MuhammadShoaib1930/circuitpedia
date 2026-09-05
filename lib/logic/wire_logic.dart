import 'package:circuitpedia/logic/copper_wire_data.dart';

class WireLogic {
  static const List<String> headings = [
    "wireGauge",
    "Diameter mm",
    "Diameter Inch",
    "Area mm2",
    "Max Ampere",
    "Length per Kilogram (m/kg)",
  ];

  static Map<String, List<dynamic>> filteredList(String value, String heading, String wireType) {
    List<String> wireGages = [];
    List<double> diameterMMs = [];
    List<double> diameterInchs = [];
    List<double> areaMM2s = [];
    List<double> maxAmperes = [];
    List<double> lengthMeterPerKgs = [];

    CopperWireData copperWireData = CopperWireData();
    if (heading == headings[0]) {
      for (int i = 0; i < copperWireData.wireGauge.length; i++) {
        if (copperWireData.wireGauge[i].startsWith(value)) {
          wireGages.add(copperWireData.wireGauge[i]);
          diameterMMs.add(copperWireData.diameterMm[i]);
          diameterInchs.add(copperWireData.diameterInch[i]);
          areaMM2s.add(copperWireData.areaMm2[i]);
          maxAmperes.add(copperWireData.getWireData(wireType, true)[i]);
          lengthMeterPerKgs.add(copperWireData.getWireData(wireType, false)[i]);
        }
      }
    } else if (heading == headings[1]) {
      for (int i = 0; i < copperWireData.diameterMm.length; i++) {
        if (copperWireData.diameterMm[i].toString().startsWith(value)) {
          wireGages.add(copperWireData.wireGauge[i]);
          diameterMMs.add(copperWireData.diameterMm[i]);
          diameterInchs.add(copperWireData.diameterInch[i]);
          areaMM2s.add(copperWireData.areaMm2[i]);
          maxAmperes.add(copperWireData.getWireData(wireType, true)[i]);
          lengthMeterPerKgs.add(copperWireData.getWireData(wireType, false)[i]);
        }
      }
    } else if (heading == headings[2]) {
      for (int i = 0; i < copperWireData.diameterInch.length; i++) {
        if (copperWireData.diameterInch[i].toString().startsWith(value)) {
          wireGages.add(copperWireData.wireGauge[i]);
          diameterMMs.add(copperWireData.diameterMm[i]);
          diameterInchs.add(copperWireData.diameterInch[i]);
          areaMM2s.add(copperWireData.areaMm2[i]);
          maxAmperes.add(copperWireData.getWireData(wireType, true)[i]);
          lengthMeterPerKgs.add(copperWireData.getWireData(wireType, false)[i]);
        }
      }
    } else if (heading == headings[3]) {
      for (int i = 0; i < copperWireData.areaMm2.length; i++) {
        if (copperWireData.areaMm2[i].toString().startsWith(value)) {
          wireGages.add(copperWireData.wireGauge[i]);
          diameterMMs.add(copperWireData.diameterMm[i]);
          diameterInchs.add(copperWireData.diameterInch[i]);
          areaMM2s.add(copperWireData.areaMm2[i]);
          maxAmperes.add(copperWireData.getWireData(wireType, true)[i]);
          lengthMeterPerKgs.add(copperWireData.getWireData(wireType, false)[i]);
        }
      }
    } else if (heading == headings[4]) {
      List<double> maxAmpere = copperWireData.getWireData(wireType, true);
      for (int i = 0; i < maxAmpere.length; i++) {
        if (maxAmpere[i].toString().startsWith(value)) {
          wireGages.add(copperWireData.wireGauge[i]);
          diameterMMs.add(copperWireData.diameterMm[i]);
          diameterInchs.add(copperWireData.diameterInch[i]);
          areaMM2s.add(copperWireData.areaMm2[i]);
          maxAmperes.add(copperWireData.getWireData(wireType, true)[i]);
          lengthMeterPerKgs.add(copperWireData.getWireData(wireType, false)[i]);
        }
      }
    } else if (heading == headings[5]) {
      List<double> lengthMeterPerKg = copperWireData.getWireData(wireType, false);
      for (int i = 0; i < lengthMeterPerKg.length; i++) {
        if (lengthMeterPerKg[i].toString().startsWith(value)) {
          wireGages.add(copperWireData.wireGauge[i]);
          diameterMMs.add(copperWireData.diameterMm[i]);
          diameterInchs.add(copperWireData.diameterInch[i]);
          areaMM2s.add(copperWireData.areaMm2[i]);
          maxAmperes.add(copperWireData.getWireData(wireType, true)[i]);
          lengthMeterPerKgs.add(copperWireData.getWireData(wireType, false)[i]);
        }
      }
    }
    return {
      WireLogic.headings[0]: wireGages,
      WireLogic.headings[1]: diameterMMs,
      WireLogic.headings[2]: diameterInchs,
      WireLogic.headings[3]: areaMM2s,
      WireLogic.headings[4]: maxAmperes,
      WireLogic.headings[5]: lengthMeterPerKgs,
    };
  }
}
