import 'dart:async';

import 'package:circuitpedia/logic/resistor_logcs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'resistor_event.dart';
part 'resistor_state.dart';

class ResistorBloc extends Bloc<ResistorEvent, ResistorState> {
  ResistorBloc()
    : super(
        ResistorState(names: [], result: 0, tolerance: "", formatValue: "", maximum: 0, minimum: 0),
      ) {
    on<SetColors>(_setColors);
    on<SetIndexColors>(_setIndexColors);
  }

  FutureOr<void> _setColors(SetColors event, Emitter<ResistorState> emit) {}

  FutureOr<void> _setIndexColors(SetIndexColors event, Emitter<ResistorState> emit) {
    List<String> s = [...state.names];
    if (event.index < s.length) {
      s[event.index] = event.name;
    } else {
      s.add(event.name);
    }
    emit(
      ResistorState(names: s, result: 0, tolerance: "", formatValue: "", maximum: 0, minimum: 0),
    );
    if (s.length > 3) {
      Map<String, dynamic> map = ResistorLogcs.calculateFromColors(s);
      Map<String, double> tol = ResistorLogcs.toleranceRange(
        value: map["value"],
        toleranceValue: map["tolerance"],
      );
      emit(
        ResistorState(
          names: map["bands"],
          result: map["value"],
          tolerance: map["tolerance"],
          formatValue: ResistorLogcs.formatValue( map["value"]),
          minimum: tol["minimum"] ?? 0,
          maximum: tol["maximum"] ?? 0,
        ),
      );
    }
  }
}
