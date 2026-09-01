part of 'wires_bloc.dart';

class WiresState extends Equatable {
  final bool isCopper;
  final bool isSearch;
  final List<String> wireGage;
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
    this.isCopper = true,
    this.isSearch = false,
    this.wireGage = const [],
    this.diameterMM = const [],
    this.diameterInch = const [],
    this.areaMM2 = const [],
    this.maxAmpere = const [],
    this.selectedRow = 0,
    this.selectedColumn = 0,
    this.lengthMeterPerKg = const [],
    this.heading = "WireGage",
    this.value = "",
  });

  @override
  List<Object> get props {
    return [
      isCopper,
      isSearch,
      wireGage,
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
    bool? isCopper,
    bool? isSearch,
    List<String>? wireGage,
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
      isCopper: isCopper ?? this.isCopper,
      isSearch: isSearch ?? this.isSearch,
      wireGage: wireGage ?? this.wireGage,
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
