import 'dart:async';

import 'package:circuitpedia/logic/transformer_logic.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'transformer_event.dart';
part 'transformer_state.dart';

class TransformerBloc extends Bloc<TransformerEvent, TransformerState> {
  TransformerBloc() : super(TransformerState()) {
    on<SetWidth>(_setWidth);
    on<SetHeight>(_setHeight);
    on<SetArea>(_setArea);
    on<SetIsVoltage>(_isVoltage);
    on<SetVoltage>(_setVoltage);
    on<SetTurns>(_setTurns);
  }

  FutureOr<void> _setWidth(SetWidth event, Emitter<TransformerState> emit) {
    double width = event.width;
    emit(state.copyWith(width: width));
    if (state.width != 0 && state.height != 0) {
      double area = TransformerLogic().findArea(state.width, state.height);
      Map<String, List<double>> map = TransformerLogic().upsCalculate(area);
      emit(state.copyWith(area: area, pt: map["pt"], pv: map["pv"], st: map["st"], sv: map["sv"]));
    }
  }

  FutureOr<void> _setHeight(SetHeight event, Emitter<TransformerState> emit) {
    double height = event.height;
    emit(state.copyWith(height: height));
    if (state.width != 0 && state.height != 0) {
      double area = TransformerLogic().findArea(state.width, state.height);
      Map<String, List<double>> map = TransformerLogic().upsCalculate(area);
      emit(state.copyWith(area: area, pt: map["pt"], pv: map["pv"], st: map["st"], sv: map["sv"]));
    }
  }

  FutureOr<void> _setArea(SetArea event, Emitter<TransformerState> emit) {
    double area = event.area;
    if (area != 0) {
      Map<String, List<double>> map = TransformerLogic().upsCalculate(area);
      emit(state.copyWith(area: area, pt: map["pt"], pv: map["pv"], st: map["st"], sv: map["sv"]));
    }
  }

  FutureOr<void> _isVoltage(SetIsVoltage event, Emitter<TransformerState> emit) {
    List<TransformerModel> model;
    if (event.index >= state.model.length - 1) {
      model = [...state.model, TransformerModel(voltage: 0, truns: 0, isVoltage: false)];
    } else {
      model = [...state.model];
    }

    model[event.index] = model[event.index].copyWith(isVoltage: event.isVoltage);
    emit(state.copyWith(model: model));
  }

  FutureOr<void> _setVoltage(SetVoltage event, Emitter<TransformerState> emit) {
    List<TransformerModel> model;
    if (event.index >= state.model.length - 1) {
      model = [...state.model, TransformerModel(voltage: 0, truns: 0, isVoltage: false)];
    } else {
      model = [...state.model];
    }
    model[event.index] = model[event.index].copyWith(
      voltage: event.voltage,
      truns: TransformerLogic().findVoltage(state.area, event.voltage),
    );
    emit(state.copyWith(model: model));
  }

  FutureOr<void> _setTurns(SetTurns event, Emitter<TransformerState> emit) {
    List<TransformerModel> model;
    if (event.index >= state.model.length - 1) {
      model = [...state.model, TransformerModel(voltage: 0, truns: 0, isVoltage: false)];
    } else {
      model = [...state.model];
    }
    model[event.index] = model[event.index].copyWith(
      voltage: TransformerLogic().findVoltageFromTruns(state.area, event.turns),
      truns: event.turns,
    );
    emit(state.copyWith(model: model));
  }
}
