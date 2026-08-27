part of 'transformer_bloc.dart';

class TransformerState extends Equatable {
  final double width;
  final double height;
  final List<double> sv;
  final List<double> st;
  final List<double> pv;
  final List<double> pt;
  final double area;
  final List<TransformerModel> model;
  const TransformerState({
    this.width = 0,
    this.height = 0,
    this.sv = const [0, 0, 0],
    this.st = const [0, 0, 0],
    this.pv = const [0, 0, 0],
    this.pt = const [0, 0, 0],
    this.area = 0,
    this.model=const [TransformerModel(isVoltage: false,truns:0,voltage: 0)],
  });

  @override
  List<Object> get props => [width, height, sv, st, pv, pt, area, model];

  TransformerState copyWith({
    double? width,
    double? height,
    List<double>? sv,
    List<double>? st,
    List<double>? pv,
    List<double>? pt,
    double? area,

    List<TransformerModel>? model,
  }) {
    return TransformerState(
      width: width ?? this.width,
      height: height ?? this.height,
      sv: sv ?? this.sv,
      st: st ?? this.st,
      pv: pv ?? this.pv,
      pt: pt ?? this.pt,
      area: area ?? this.area,
      model: model??this.model
    );
  }
}
