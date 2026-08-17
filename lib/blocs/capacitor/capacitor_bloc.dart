import 'dart:async';
import 'dart:ffi';

import 'package:circuitpedia/logic/capacitor_logics.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'capacitor_event.dart';
part 'capacitor_state.dart';

class CapacitorBloc extends Bloc<CapacitorEvent, CapacitorState> {
  CapacitorBloc() : super(CapacitorState()) {
    on<CeramicCalculate>(_ceramicCalculate);
    on<PolyesterCalculate>(_polyesterCalculate);
    on<ValueConvert>(_valueConvert);
  }

  FutureOr<void> _ceramicCalculate(CeramicCalculate event, Emitter<CapacitorState> emit) {
    CapacitorState newState = state;
    emit(CapacitorState());
    if (event.isCodeToValue) {
      String res = CapacitorLogics().codeToPF(event.data);
      emit(newState.copyWith(ceramicValue: "$res pf"));
    } else {
      String res = CapacitorLogics().pfToCode(event.data);
      emit(newState.copyWith(ceramicCode: res));
    }
  }

  FutureOr<void> _polyesterCalculate(PolyesterCalculate event, Emitter<CapacitorState> emit) {
    if (event.isCodeToValue) {
      String res = CapacitorLogics().codeToPF(event.data);
      emit(state.copyWith(polyesterValue: "$res pf"));
    } else {
      String res = CapacitorLogics().pfToCode(event.data);
      emit(state.copyWith(polyesterCode: res));
    }
  }

  FutureOr<void> _valueConvert(ValueConvert event, Emitter<CapacitorState> emit) {
    emit(state.copyWith(toValue: CapacitorLogics().convert(event.data)));
  }
}
