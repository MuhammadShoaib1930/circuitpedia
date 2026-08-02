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
  const SetResisterColors({required this.position, required this.index, this.isFour = false});

  @override
  List<Object> get props => [position, index];
}

final class SetResisterValue extends ResistorEvent {
  final int value;
  final String symbol;
  final String percentage;
  final bool isFour;
  const SetResisterValue({
    required this.value,
    required this.percentage,
    required this.symbol,
    this.isFour = true,
  });
  @override
  List<Object> get props => [value, symbol, percentage];
}

final class SetResisterPercentage extends ResistorEvent {
  final String percentage;
  final bool isFour;
  const SetResisterPercentage({required this.percentage, this.isFour = true});
  @override
  List<Object> get props => [percentage];
}

final class Convert extends ResistorEvent {
  final String symbols;
  final bool isFour;
  const Convert(this.symbols, [this.isFour = true]);
}
