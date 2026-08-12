import 'dart:async';
import 'dart:io';

import 'package:circuitpedia/logic/resistor_logcs.dart';
import 'package:circuitpedia/models/resistor_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'resistor_event.dart';
part 'resistor_state.dart';

class ResistorBloc extends Bloc<ResistorEvent, ResistorState> {
  ResistorBloc() : super(ResistorState()) {
    on<SetResisterColors>(_setResisterColors);
    on<SetPersentage>(_setPersentage);
    on<SetValueColors>(_setValueColors);
  }

  FutureOr<void> _setResisterColors(SetResisterColors event, Emitter<ResistorState> emit) {
    if (event.isFour) {
      emit(
        ResistorState(
          resistorModel4: ResistorLogcs().colorToValue(
            resistorModel: state.resistorModel4,
            position: event.position,
            index: event.index,
            isFour: true,
            symbol: event.symbol,
          ),
          resistorModel5: state.resistorModel5,
        ),
      );
    } else {
      emit(
        ResistorState(
          resistorModel5: ResistorLogcs().colorToValue(
            resistorModel: state.resistorModel5,
            position: event.position,
            index: event.index,
            isFour: false,
            symbol: event.symbol,
          ),
          resistorModel4: state.resistorModel4,
        ),
      );
    }
  }

  FutureOr<void> _setPersentage(SetPersentage event, Emitter<ResistorState> emit) {
    if (event.isFour) {
      emit(
        state.copyWith(
          resistorModel4: state.resistorModel4.copyWith(
            resistor3Index: event.index,
            resultpercentage: Data.resistorPersentage[event.index],
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          resistorModel5: state.resistorModel5.copyWith(
            resistor4Index: event.index,
            resultpercentage: Data.resistorPersentage[event.index],
          ),
        ),
      );
    }
  }

  FutureOr<void> _setValueColors(SetValueColors event, Emitter<ResistorState> emit) {
    
  }
}
