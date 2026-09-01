part of 'transformer_bloc.dart';

class TransformerState extends Equatable {
  final double width;
  final double height;
  final List<double> sv;
  final List<double> st;
  final List<double> pv;
  final List<double> pt;
  final List<double> voltages;
  final double area;
  final bool isArea;
  final List<bool> isCopper;
  final List<double> watts;
  final List<double> currents;
  final List<double> grams;
  final List<String> wireGages;

  final List<TransformerModel> model;
  const TransformerState({
    this.width = 0,
    this.height = 0,
    this.sv = const [0, 0, 0],
    this.st = const [0, 0, 0],
    this.pv = const [0, 0, 0],
    this.pt = const [0, 0, 0],
    this.area = 0,
    this.model = const [TransformerModel(isVoltage: false, truns: 0, voltage: 0)],
    this.isArea = true,
    this.voltages = const [0],
    this.watts = const [0],
    this.currents = const [0],
    this.grams = const [0],
    this.wireGages = const ["50"],
    this.isCopper = const [false],
  });

  @override
  List<Object> get props => [
    width,
    height,
    sv,
    st,
    pv,
    pt,
    area,
    model,
    isArea,
    voltages,
    watts,
    currents,
    grams,
    wireGages,
    isCopper,
  ];

  TransformerState copyWith({
    double? width,
    double? height,
    List<double>? sv,
    List<double>? st,
    List<double>? pv,
    List<double>? pt,
    double? area,
    bool? isArea,
    List<double>? voltages,

    List<double>? watts,
    List<double>? currents,
    List<double>? grams,
    List<String>? wireGages,
    List<TransformerModel>? model,
    List<bool>? isCopper,
  }) {
    return TransformerState(
      width: width ?? this.width,
      height: height ?? this.height,
      sv: sv ?? this.sv,
      st: st ?? this.st,
      pv: pv ?? this.pv,
      pt: pt ?? this.pt,
      area: area ?? this.area,
      model: model ?? this.model,
      isArea: isArea ?? this.isArea,
      voltages: voltages ?? this.voltages,
      watts: watts ?? this.watts,
      currents: currents ?? this.currents,
      grams: grams ?? this.grams,
      wireGages: wireGages ?? this.wireGages,
      isCopper: isCopper ?? this.isCopper,
    );
  }
}
