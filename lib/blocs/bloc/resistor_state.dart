// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'resistor_bloc.dart';

class ResistorState extends Equatable {
  final ResistorModel resistorModel4;
  final ResistorModel resistorModel5;
  const ResistorState({
    this.resistorModel4 = const ResistorModel(
      resistor0Index: 12,
      resistor1Index: 12,
      resistor2Index: 12,
      resistor3Index: 12,
      resistor4Index: 12,
      resultValue: 0,
      resultsymbol: "Ω",
      resultpercentage: "±0%",
    ),
    this.resistorModel5 = const ResistorModel(
      resistor0Index: 12,
      resistor1Index: 12,
      resistor2Index: 12,
      resistor3Index: 12,
      resistor4Index: 12,
      resultValue: 0,
      resultsymbol: "Ω",
      resultpercentage: "±0%",
    ),
  });

  @override
  List<Object> get props => [resistorModel4, resistorModel5];

  ResistorState copyWith({
    ResistorModel? resistorModel4,
    ResistorModel? resistorModel5,
  }) {
    return ResistorState(
      resistorModel4: resistorModel4 ?? this.resistorModel4,
      resistorModel5: resistorModel5 ?? this.resistorModel5,
    );
  }
}
