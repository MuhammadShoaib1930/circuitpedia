part of 'resistor_bloc.dart';

sealed class ResistorEvent extends Equatable {
  const ResistorEvent();

  @override
  List<Object> get props => [];
}

final class SetResisterColors extends ResistorEvent {
  final int position;
  final int index;
  final String symbol;
  const SetResisterColors({this.position = -1, this.index = -1, this.symbol = "Ω"});

  @override
  List<Object> get props => [position, index, symbol];
}

final class SetPersentage extends ResistorEvent {
  final int index;
  const SetPersentage(this.index);
  @override
  List<Object> get props => [index];
}

final class SetValueColors extends ResistorEvent {
  final double value;
  const SetValueColors(this.value);
  @override
  List<Object> get props => [value];
}
