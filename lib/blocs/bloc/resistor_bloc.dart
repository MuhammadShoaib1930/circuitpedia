import 'dart:async';

import 'package:circuitpedia/logic/resistor_logcs.dart';
import 'package:circuitpedia/models/resistor_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'resistor_event.dart';
part 'resistor_state.dart';

class ResistorBloc extends Bloc<ResistorEvent, ResistorState> {
  ResistorBloc() : super(ResistorState()) {
    on<SetResisterColors>(_setResisterColors);
    on<Convert>(_convert);
    on<SetResisterValue>(_setResisterValue);
    on<SetResisterPercentage>(_setResisterPercentage);
  }

  FutureOr<void> _setResisterColors(SetResisterColors event, Emitter<ResistorState> emit) {
    if (event.isFour) {
      List<int> data = [
        state.resistorModel4.resistor0Index,
        state.resistorModel4.resistor1Index,
        state.resistorModel4.resistor2Index,
        state.resistorModel4.resistor3Index,
      ];
      data[event.position] = event.index;
      emit(
        ResistorState(
          resistorModel4: ResistorLogcs().colorToValue(
            resistorModel: state.resistorModel4,
            data: data,
          ),
          resistorModel5: state.resistorModel5,
        ),
      );
    } else {
      
    }
  }

  FutureOr<void> _convert(Convert event, Emitter<ResistorState> emit) {}

  FutureOr<void> _setResisterValue(SetResisterValue event, Emitter<ResistorState> emit) {}

  FutureOr<void> _setResisterPercentage(SetResisterPercentage event, Emitter<ResistorState> emit) {}
}
