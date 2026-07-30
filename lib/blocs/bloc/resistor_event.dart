part of 'resistor_bloc.dart';

sealed class ResistorEvent extends Equatable {
  const ResistorEvent();

  @override
  List<Object> get props => [];
}

final class SetResisterColors extends ResistorEvent {
  final int posstion;
  final String colorName;
  final bool isfourColuors;

  const SetResisterColors({
    required this.posstion,
    required this.colorName,
    this.isfourColuors = true,
  });

  @override
  List<Object> get props => [posstion, colorName, isfourColuors];
}

final class Convert extends ResistorEvent {
  final String symbols;
  const Convert(this.symbols);
}
