part of 'smd_resistor_bloc.dart';

sealed class SmdResistorEvent extends Equatable {
  const SmdResistorEvent();

  @override
  List<Object> get props => [];
}

class ValueToCode extends SmdResistorEvent {
  final String value;
  const ValueToCode({required this.value});

  @override
  List<Object> get props => [value];
}

class CodeToValue extends SmdResistorEvent {
  final String code;
  const CodeToValue({required this.code});

  @override
  List<Object> get props => [code];
}
