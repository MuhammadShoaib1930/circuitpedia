part of 'resistor_bloc.dart';

sealed class ResistorEvent extends Equatable {
  const ResistorEvent();

  @override
  List<Object> get props => [];
}

class SetColors extends ResistorEvent {
  final List<String> names;
  const SetColors({required this.names});

  @override
  List<Object> get props => [names];
}

class SetIndexColors extends ResistorEvent {
  final int index;
  final String name;
  const SetIndexColors({required this.index, required this.name});

  @override
  List<Object> get props => [index, name];
}
