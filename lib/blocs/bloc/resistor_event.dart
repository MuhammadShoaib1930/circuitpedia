part of 'resistor_bloc.dart';

sealed class ResistorEvent extends Equatable {
  const ResistorEvent();

  @override
  List<Object> get props => [];
}

final class SetResisterColors extends ResistorEvent {
  final int position;
  final int index;
  final bool isFour;
  final String symbol;
  const SetResisterColors({
    this.position = -1,
    this.index = -1,
    this.isFour = false,
    this.symbol = "Ω",
  });

  @override
  List<Object> get props => [position, index, isFour, symbol];
}

final class SetPersentage extends ResistorEvent {
  final int index;
  final bool isFour;
  const SetPersentage(this.index, this.isFour);
  @override
  List<Object> get props => [index, isFour];
}

final class SetValueColors extends ResistorEvent {
  final double value;
  final bool isFour;
  const SetValueColors(this.value, this.isFour);
  @override
  List<Object> get props => [value, isFour];
}
