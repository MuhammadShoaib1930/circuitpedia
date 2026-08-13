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
    on<SetPersentage>(_setPersentage);
    on<SetValueColors>(_setValueColors);
  }
  ResistorModel _setMinMaxRange(ResistorModel m) {
    double minR = 0, maxR = 0;
    (minR, maxR) = ResistorLogcs().getMinMax(m.resultValue, m.resultpercentage);
    return m.copyWith(minRange: minR, maxRange: maxR);
  }

  FutureOr<void> _setResisterColors(SetResisterColors event, Emitter<ResistorState> emit) {
    emit(
      ResistorState(
        resistorModel4: _setMinMaxRange(
          ResistorLogcs().colorToValue(
            resistorModel: state.resistorModel4,
            position: event.position,
            index: event.index,
            symbol: event.symbol,
          ),
        ),
      ),
    );
  }

  FutureOr<void> _setPersentage(SetPersentage event, Emitter<ResistorState> emit) {
    emit(
      state.copyWith(
        resistorModel4: _setMinMaxRange(
          state.resistorModel4.copyWith(
            resistor3Index: event.index,
            resultpercentage: Data.resistorPersentage[event.index],
          ),
        ),
      ),
    );
  }

  FutureOr<void> _setValueColors(SetValueColors event, Emitter<ResistorState> emit) {
    emit(
      state.copyWith(
        resistorModel4: _setMinMaxRange(
          ResistorLogcs()
              .valueToColors(value: event.value, model: state.resistorModel4).copyWith(resultValue: event.value)
        ),
      ),
    );
  }
}
