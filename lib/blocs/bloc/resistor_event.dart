part of 'resistor_bloc.dart';

sealed class ResistorEvent extends Equatable {
  const ResistorEvent();

  @override
  List<Object> get props => [];
}

class SetIndexColors extends ResistorEvent {
  final int index;
  final String name;
  const SetIndexColors({required this.index, required this.name});

  @override
  List<Object> get props => [index, name];
}

class ColorsFromValue extends ResistorEvent {
  final String value;
  final String tolerance;
  final int band;
  const ColorsFromValue({required this.value, required this.tolerance,required this.band});

  @override
  List<Object> get props => [value, tolerance,band];
}
