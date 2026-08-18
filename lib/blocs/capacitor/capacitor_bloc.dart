import 'dart:async';
import 'package:circuitpedia/logic/capacitor_logics.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'capacitor_event.dart';
part 'capacitor_state.dart';

class CapacitorBloc extends Bloc<CapacitorEvent, CapacitorState> {
  CapacitorBloc() : super(CapacitorState()) {
    on<SetValue>(_setValue);
    on<SetCode>(_setCode);
  }

  FutureOr<void> _setValue(SetValue event, Emitter<CapacitorState> emit) {
    String data = event.data;
    if (data.isEmpty) {
      emit(CapacitorState(value: data));
    } else {
      String code = CapacitorLogics().valueToCode(data);
      List<String> toValue = CapacitorLogics().convert(data);
      if (code.length > 3) {
        code = "0";
      }
      emit(CapacitorState(code: code, value: data, toValue: toValue));
    }
  }

  FutureOr<void> _setCode(SetCode event, Emitter<CapacitorState> emit) {
    String data = event.data;
    if (data.isEmpty) {
      emit(state.copyWith(code: data));
    } else {
      String value = CapacitorLogics().codeToValue(data);
      List<String> toValue = CapacitorLogics().convert(value);
      emit(CapacitorState(code: data, value: value, toValue: toValue));
    }
  }
}
