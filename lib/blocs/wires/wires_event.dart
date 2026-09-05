part of 'wires_bloc.dart';

sealed class WiresEvent extends Equatable {
  const WiresEvent();

  @override
  List<Object> get props => [];
}

class Search extends WiresEvent {
  final String value;
  final String heading;
  const Search({this.value = "", this.heading = ""});
  @override
  List<String> get props => [heading, value];
}

class WireType extends WiresEvent {
  final String wireType;
  const WireType(this.wireType);
  @override
  List<String> get props => [wireType];
}

class SelectedRowColumn extends WiresEvent {
  final int row;
  final int column;
  const SelectedRowColumn({required this.row, required this.column});
  @override
  List<int> get props => [row, column];
}

class InitalGetData extends WiresEvent {
  final String wireType;
  final String heading;
  const InitalGetData({required this.wireType, required this.heading});
}
