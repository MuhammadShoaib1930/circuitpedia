part of 'capacitor_bloc.dart';

class CapacitorState extends Equatable {
  final String code;
  final String value;
  final List<String> toValue;
  const CapacitorState({
    this.code = "0",
    this.value = "0 pF",
    this.toValue = const ["0 pF", "0 pF", "0 pF", "0 pF", "0 pF"],
  });

  @override
  List<Object> get props => [code, toValue, value];

  CapacitorState copyWith({String? code, String? value, List<String>? toValue}) {
    return CapacitorState(
      code: code ?? this.code,
      value: value ?? this.value,
      toValue: toValue ?? this.toValue,
    );
  }
}
