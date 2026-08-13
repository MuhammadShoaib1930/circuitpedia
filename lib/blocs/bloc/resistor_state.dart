// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'resistor_bloc.dart';

class ResistorState extends Equatable {
  final ResistorModel resistorModel4;
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
      minRange: 0,
      maxRange: 0,
    ),
  });

  @override
  List<Object> get props => [resistorModel4];

  ResistorState copyWith({ResistorModel? resistorModel4}) {
    return ResistorState(resistorModel4: resistorModel4 ?? this.resistorModel4);
  }
}
