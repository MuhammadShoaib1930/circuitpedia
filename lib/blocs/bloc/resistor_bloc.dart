import 'dart:async';

import 'package:circuitpedia/logic/resistor_logcs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'resistor_event.dart';
part 'resistor_state.dart';

class ResistorBloc extends Bloc<ResistorEvent, ResistorState> {
  ResistorBloc()
    : super(
        ResistorState(
          names: [],
          result: 0,
          tolerance: "",
          formatValue: "",
          maximum: "",
          minimum: "",
        ),
      ) {
    on<ColorsFromValue>(_colorsFormValue);
    on<SetIndexColors>(_setIndexColors);
  }

  FutureOr<void> _setIndexColors(SetIndexColors event, Emitter<ResistorState> emit) {
    List<String> s = [...state.names];
    if (event.index < s.length) {
      s[event.index] = event.name;
    } else {
      s.add(event.name);
    }
    emit(
      ResistorState(names: s, result: 0, tolerance: "", formatValue: "", maximum: "", minimum: ""),
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
          formatValue: ResistorLogcs.formatValue(map["value"]),
          minimum: ResistorLogcs.formatValue(tol["minimum"] ?? 0),
          maximum: ResistorLogcs.formatValue(tol["maximum"] ?? 0),
        ),
      );
    }
  }

  FutureOr<void> _colorsFormValue(ColorsFromValue event, Emitter<ResistorState> emit) {

    double value = double.parse(event.value);
    final List<String> names = ResistorLogcs.colorsFromValueAndTolerance(
      double.parse(event.value),
      event.tolerance,
      bands: event.band,
    );

    final Map<String, double> tol = ResistorLogcs.toleranceRange(
      value: value,
      toleranceValue: event.tolerance,
    );
    emit(
      ResistorState(
        names: names,
        result: value,
        tolerance: event.tolerance,
        formatValue: ResistorLogcs.formatValue(value),
        minimum: ResistorLogcs.formatValue(tol["minimum"] ?? 0),
        maximum: ResistorLogcs.formatValue(tol["maximum"] ?? 0),
      ),
    );
  }
}
