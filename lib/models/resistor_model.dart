// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ResistorModel extends Equatable {
  final int resistor0Index;
  final int resistor1Index;
  final int resistor2Index;
  final int resistor3Index;
  final int resistor4Index;
  final double resultValue;
  final String resultsymbol;
  final String resultpercentage;
  final double minRange;
  final double maxRange;
  const ResistorModel({
    required this.resistor0Index,
    required this.resistor1Index,
    required this.resistor2Index,
    required this.resistor3Index,
    required this.resistor4Index,
    required this.resultValue,
    required this.resultsymbol,
    required this.resultpercentage,
    required this.maxRange,
    required this.minRange,
  });

  @override
  List<Object> get props => [
    resistor0Index,
    resistor1Index,
    resistor2Index,
    resistor3Index,
    resistor4Index,
    resultValue,
    resultsymbol,
    resultpercentage,
    minRange,
    maxRange,
  ];

  ResistorModel copyWith({
    int? resistor0Index,
    int? resistor1Index,
    int? resistor2Index,
    int? resistor3Index,
    int? resistor4Index,
    double? resultValue,
    String? resultsymbol,
    String? resultpercentage,
    double? minRange,
    double? maxRange,
  }) {
    return ResistorModel(
      resistor0Index: resistor0Index ?? this.resistor0Index,
      resistor1Index: resistor1Index ?? this.resistor1Index,
      resistor2Index: resistor2Index ?? this.resistor2Index,
      resistor3Index: resistor3Index ?? this.resistor3Index,
      resistor4Index: resistor4Index ?? this.resistor4Index,
      resultValue: resultValue ?? this.resultValue,
      resultsymbol: resultsymbol ?? this.resultsymbol,
      resultpercentage: resultpercentage ?? this.resultpercentage,
      maxRange: maxRange ?? this.maxRange,
      minRange: minRange ?? this.minRange,
    );
  }
}
