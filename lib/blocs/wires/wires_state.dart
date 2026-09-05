part of 'wires_bloc.dart';

class WiresState extends Equatable {
  final String wireType;
  final bool isSearch;
  final List<String> wireGauge;
  final List<double> diameterMM;
  final List<double> diameterInch;
  final List<double> areaMM2;
  final List<double> maxAmpere;
  final int selectedRow;
  final int selectedColumn;
  final List<double> lengthMeterPerKg;
  final String heading;
  final String value;
  const WiresState({
    this.wireType = "Copper",
    this.isSearch = false,
    this.wireGauge = const [""],
    this.diameterMM = const [0],
    this.diameterInch = const [0],
    this.areaMM2 = const [0],
    this.maxAmpere = const [0],
    this.selectedRow = 0,
    this.selectedColumn = 0,
    this.lengthMeterPerKg = const [0],
    this.heading = "WireGage",
    this.value = "",
  });

  @override
  List<Object> get props {
    return [
      wireType,
      isSearch,
      wireGauge,
      diameterMM,
      diameterInch,
      areaMM2,
      maxAmpere,
      selectedRow,
      selectedColumn,
      lengthMeterPerKg,
      heading,
      value,
    ];
  }

  WiresState copyWith({
    String? wireType,
    bool? isSearch,
    List<String>? wireGauge,
    List<double>? diameterMM,
    List<double>? diameterInch,
    List<double>? areaMM2,
    List<double>? maxAmpere,
    int? selectedRow,
    int? selectedColumn,
    List<double>? lengthMeterPerKg,
    String? heading,
    String? value,
  }) {
    return WiresState(
      wireType: wireType ?? this.wireType,
      isSearch: isSearch ?? this.isSearch,
      wireGauge: wireGauge ?? this.wireGauge,
      diameterMM: diameterMM ?? this.diameterMM,
      diameterInch: diameterInch ?? this.diameterInch,
      areaMM2: areaMM2 ?? this.areaMM2,
      maxAmpere: maxAmpere ?? this.maxAmpere,
      selectedRow: selectedRow ?? this.selectedRow,
      selectedColumn: selectedColumn ?? this.selectedColumn,
      lengthMeterPerKg: lengthMeterPerKg ?? this.lengthMeterPerKg,
      heading: heading ?? this.heading,
      value: value ?? this.value,
    );
  }
}
