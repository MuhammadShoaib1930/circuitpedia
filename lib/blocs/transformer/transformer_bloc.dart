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
    on<SetIsArea>(_setIsArea);
    on<TransformerInformation>(_transformerInformation);
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

  FutureOr<void> _setIsArea(SetIsArea event, Emitter<TransformerState> emit) {
    emit(state.copyWith(isArea: event.isTrue));
  }

  FutureOr<void> _transformerInformation(
    TransformerInformation event,
    Emitter<TransformerState> emit,
  ) {
    if (event.index == -1 && event.area != 0) {
      emit(state.copyWith(area: event.area));
    }
    if (event.index == -1) {
      if (event.height != 0) {
        emit(
          state.copyWith(
            width: state.width,
            height: event.height,
            area: TransformerLogic().findArea(event.width, event.height),
          ),
        );
      } else {
        emit(
          state.copyWith(
            width: event.width,
            height: state.height,
            area: TransformerLogic().findArea(event.width, event.height),
          ),
        );
      }
    }
    if (event.index != -1) {
      if (event.voltage != 0) {
        List<double> voltage = state.voltages;
        voltage[event.index] = event.voltage;
        emit(state.copyWith(voltages: voltage));
      }
      if (event.wireGage != "") {
        List<String> wireGages = state.wireGages;
        state.wireGages[event.index] = event.wireGage;
        emit(state.copyWith(wireGages: wireGages));
      }
      if (state.voltages.isNotEmpty && state.wireGages.isNotEmpty && state.area != 0) {
        Map<String, List<double>> map = TransformerLogic().transformerInformation(
          area: state.area,
          voltages: (event.index == state.voltages.length - 1)
              ? [...state.voltages, 0]
              : state.voltages,
          wireGages: (event.index == state.voltages.length - 1)
              ? [...state.wireGages, " "]
              : state.wireGages,
        );

        emit(
          state.copyWith(
            voltages: state.voltages,
            wireGages: state.wireGages,
            watts: map["watts"]!,
            currents: map['currents']!,
            kgs: map['kgs']!,
          ),
        );
      }
    }
  }
}
