import 'dart:async';

import 'package:circuitpedia/logic/resistor_logcs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'resistor_event.dart';
part 'resistor_state.dart';

class ResistorBloc extends Bloc<ResistorEvent, ResistorState> {
  ResistorBloc() : super(ResistorState()) {
    on<SetResisterColors>(_setResisterColors);
    on<Convert>(_convert);
  }

  FutureOr<void> _setResisterColors(
    SetResisterColors event,
    Emitter<ResistorState> emit,
  ) {
    ResistorLogcs resistorLogcs = ResistorLogcs();
    List<String> nameList4 = [...state.colorsName4];
    List<String> nameList5 = [...state.colorsName5];
    if (event.isfourColuors) {
      nameList4[event.posstion] = event.colorName;
    } else {
      nameList5[event.posstion] = event.colorName;
    }

    emit(
      ResistorState(
        colorsName4: nameList4,
        colorsName5: nameList5,
        result4: resistorLogcs.calculated(names: nameList4),
        result5: resistorLogcs.calculated(names: nameList5),
      ),
    );
  }

  FutureOr<void> _convert(Convert event, Emitter<ResistorState> emit) {
    ResistorLogcs resistorLogcs = ResistorLogcs();
    String result = resistorLogcs.valuesToAlphanumeric(
      event.symbols,
      state.result4,
    );
    emit(state.copyWith(result4: result));
  }
}
