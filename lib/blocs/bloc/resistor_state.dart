part of 'resistor_bloc.dart';

class ResistorState extends Equatable {
  final List<String> names;
  final double result;
  final String tolerance;
  final String formatValue;

  final String minimum;
  final String maximum;

  const ResistorState({
    required this.names,
    required this.result,
    required this.tolerance,
    required this.formatValue,
    required this.maximum,
    required this.minimum,
  });
  @override
  List<Object> get props => [
    names,
    result,
    tolerance,
    formatValue,
    minimum,
    maximum,
  ];
}
