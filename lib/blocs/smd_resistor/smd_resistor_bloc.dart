import 'dart:async';

import 'package:circuitpedia/logic/resistor_logcs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'smd_resistor_event.dart';
part 'smd_resistor_state.dart';

class SmdResistorBloc extends Bloc<SmdResistorEvent, SmdResistorState> {
  SmdResistorBloc() : super(SmdResistorState()) {
    on<CodeToValue>(_codeToValue);
    on<ValueToCode>(_valueTOCode);
  }

  FutureOr<void> _codeToValue(CodeToValue event, Emitter<SmdResistorState> emit) {
    String code = event.code;
    String value = SMDResistorLogic().codeToValue(code);
    print(code);
    print(value);
    emit(SmdResistorState(code: code, value: value));
  }

  FutureOr<void> _valueTOCode(ValueToCode event, Emitter<SmdResistorState> emit) {
    String value = event.value;
    String code = SMDResistorLogic().valueToCode(value);
    print(value);
    print(code);
    emit(SmdResistorState(value: value, code: code));
  }
}
