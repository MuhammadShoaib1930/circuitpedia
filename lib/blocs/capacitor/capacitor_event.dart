part of 'capacitor_bloc.dart';

sealed class CapacitorEvent extends Equatable {
  const CapacitorEvent();

  @override
  List<Object> get props => [];
}

class SetCode extends CapacitorEvent {
  final String data;
  const SetCode({required this.data});
  @override
  List<Object> get props => [data];
}

class SetValue extends CapacitorEvent {
  final String data;
  const SetValue({required this.data});
  @override
  List<Object> get props => [data];
}

