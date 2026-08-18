part of 'smd_resistor_bloc.dart';

class SmdResistorState extends Equatable {
  final String code;
  final String value;
  const SmdResistorState({this.code = "0", this.value = "0 pΩ"});

  @override
  List<String> get props => [code, value];
}
