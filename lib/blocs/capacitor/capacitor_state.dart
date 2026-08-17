part of 'capacitor_bloc.dart';

class CapacitorState extends Equatable {
  final String ceramicCode;
  final String ceramicValue;
  final String polyesterCode;
  final String polyesterValue;
  final String value;
  final List<String> toValue;
  const CapacitorState({
    this.ceramicCode = "0",
    this.ceramicValue = "0",
    this.polyesterCode = "0",
    this.polyesterValue = "0",
    this.toValue = const ["0pf", "0pf", "0pf", "0pf", "0pf"],
    this.value = "0",
  });

  @override
  List<Object> get props => [
    ceramicCode,
    ceramicValue,
    polyesterCode,
    polyesterValue,
    toValue,
    value,
  ];

  CapacitorState copyWith({
    String? ceramicCode,
    String? ceramicValue,
    String? polyesterCode,
    String? polyesterValue,
    String? value,
    List<String>? toValue,
  }) {
    return CapacitorState(
      ceramicCode: ceramicCode ?? this.ceramicCode,
      ceramicValue: ceramicValue ?? this.ceramicValue,
      polyesterCode: polyesterCode ?? this.polyesterCode,
      polyesterValue: polyesterValue ?? this.polyesterValue,
      value: value ?? this.value,
      toValue: toValue ?? this.toValue,
    );
  }
}
