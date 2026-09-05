part of 'transformer_bloc.dart';

sealed class TransformerEvent extends Equatable {
  const TransformerEvent();

  @override
  List<Object> get props => [];
}

final class SetWidth extends TransformerEvent {
  final double width;
  const SetWidth({required this.width});
  @override
  List<Object> get props => [width];
}

final class SetHeight extends TransformerEvent {
  final double height;
  const SetHeight({required this.height});
  @override
  List<Object> get props => [height];
}

final class SetArea extends TransformerEvent {
  final double area;
  const SetArea({required this.area});
  @override
  List<Object> get props => [area];
}

final class SetVoltage extends TransformerEvent {
  final double voltage;
  final int index;
  const SetVoltage({required this.voltage, required this.index});
  @override
  List<Object> get props => [voltage, index];
}

final class SetTurns extends TransformerEvent {
  final double turns;
  final int index;
  const SetTurns({required this.turns, required this.index});
  @override
  List<Object> get props => [turns, index];
}

final class SetIsVoltage extends TransformerEvent {
  final int index;
  final bool isVoltage;
  const SetIsVoltage({required this.isVoltage, required this.index});
  @override
  List<Object> get props => [isVoltage, index];
}

final class SetIsArea extends TransformerEvent {
  final bool isTrue;
  const SetIsArea(this.isTrue);
  @override
  List<Object> get props => [isTrue];
}

final class TransformerInformation extends TransformerEvent {
  final double area;
  final double voltage;
  final String wireGage;
  final double width;
  final double height;
  final int index;
  final String wireType;
  const TransformerInformation({
    this.area = -1,
    this.voltage = -1,
    this.wireGage = "",
    this.width = -1,
    this.index = -1,
    this.height = -1,
    this.wireType = "",
  });
  @override
  List<Object> get props => [area, voltage, wireGage, width, height, index, wireType];
}
