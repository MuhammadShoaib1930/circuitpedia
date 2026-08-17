part of 'capacitor_bloc.dart';

sealed class CapacitorEvent extends Equatable {
  const CapacitorEvent();

  @override
  List<Object> get props => [];
}

class CeramicCalculate extends CapacitorEvent {
  final String data;
  final bool isCodeToValue;
  const CeramicCalculate({required this.data, required this.isCodeToValue});
  @override
  List<Object> get props => [data, isCodeToValue];
}

class PolyesterCalculate extends CapacitorEvent {
  final String data;
  final bool isCodeToValue;
  const PolyesterCalculate({required this.data, required this.isCodeToValue});
  @override
  List<Object> get props => [data, isCodeToValue];
}

class ValueConvert extends CapacitorEvent {
  final String data;
  const ValueConvert({required this.data});
  @override
  List<Object> get props => [data];
}
