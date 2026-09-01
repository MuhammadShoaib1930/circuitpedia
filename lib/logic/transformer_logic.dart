import 'package:circuitpedia/logic/copper_wire_data.dart';
import 'package:equatable/equatable.dart';

class TransformerModel extends Equatable {
  final double voltage;
  final double truns;
  final bool isVoltage;
  const TransformerModel({required this.voltage, required this.truns, required this.isVoltage});

  @override
  List<Object> get props => [voltage, truns, isVoltage];

  TransformerModel copyWith({double? voltage, double? truns, bool? isVoltage}) {
    return TransformerModel(
      voltage: voltage ?? this.voltage,
      truns: truns ?? this.truns,
      isVoltage: isVoltage ?? this.isVoltage,
    );
  }
}

class TransformerLogic {
  double findArea(double width, double height) {
    return (width * height).ceilToDouble();
  }

  double findTrunsPerVoltage(double area) {
    return 8.0 / area;
  }

  double findVoltageFromTruns(double area, double trun) {
    return (trun / findTrunsPerVoltage(area)).ceilToDouble();
  }

  double findVoltage(double area, double voltage) {
    return findTrunsPerVoltage(area) * voltage;
  }

  Map<String, List<dynamic>> transformerInformation({
    required double area,
    required List<double> voltages,
    required List<String> wireGages,
    required List<bool> isCopper,
  }) {
    int n = voltages.length;
    List<double> watts = List.filled(n, 0);
    List<double> currents = List.filled(n, 0);
    List<double> grams = List.filled(n, 0);
    for (int i = 0; i < voltages.length; i++) {
      currents[i] = (CopperWireData().getWireToCurrent(gauge: wireGages[i], isCopper: isCopper[i]));
      watts[i] = (currents[i] * voltages[i]);
      grams[i] = double.parse(
        ((area * (findTrunsPerVoltage(area) * voltages[i]) * 66) /
                CopperWireData().getWireToLenthMeterPerKg(
                  gauge: wireGages[i],
                  isCopper: isCopper[i],
                ))
            .toStringAsFixed(2),
      );
    }
    return {"watts": watts, "currents": currents, "grams": grams, "isCopper": isCopper};
  }

  Map<String, List<double>> upsCalculate(double area) {
    List<double> pv = [12.0, 0.0, 12.0];
    List<double> sv = [0.0, 140.0, 260.0];
    double tpv = findTrunsPerVoltage(area);
    List<double> pt = [tpv * pv[0], tpv * pv[1], tpv * pv[2]];
    List<double> st = [tpv * sv[0], tpv * sv[1], tpv * sv[2]];
    return {"pv": pv, "pt": pt, "sv": sv, "st": st};
  }
}
