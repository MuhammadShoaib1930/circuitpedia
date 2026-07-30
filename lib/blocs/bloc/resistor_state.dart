// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'resistor_bloc.dart';

class ResistorState extends Equatable {
  final List<String> colorsName4;
  final String result4;
  final List<String> colorsName5;
  final String result5;
  const ResistorState({
    this.colorsName4 = const ["None", "None", "None", "None"],
    this.colorsName5 = const ["None", "None", "None", "None", "None"],
    this.result4 = "0 Ω %0.0",
    this.result5 = "0 Ω %0.0",
  });

  @override
  List<Object> get props => [colorsName4, colorsName5, result4, result5];

  ResistorState copyWith({
    List<String>? colorsName4,
    String? result4,
    List<String>? colorsName5,
    String? result5,
  }) {
    return ResistorState(
      colorsName4: colorsName4 ?? this.colorsName4,
      result4: result4 ?? this.result4,
      colorsName5: colorsName5 ?? this.colorsName5,
      result5: result5 ?? this.result5,
    );
  }
}
