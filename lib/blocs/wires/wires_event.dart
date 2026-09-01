// ignore_for_file: public_member_api_docs, sort_constructors_first
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

class Toggle extends WiresEvent {
  final bool isTrue;
  const Toggle(this.isTrue);
  @override
  List<bool> get props => [isTrue];
}

class SelectedRowColumn extends WiresEvent {
  final int row;
  final int column;
  const SelectedRowColumn({required this.row, required this.column});
  @override
  List<int> get props => [row, column];
}
