import 'dart:async';

import 'package:circuitpedia/logic/copper_wire_data.dart';
import 'package:circuitpedia/logic/wire_logic.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wires_event.dart';
part 'wires_state.dart';

class WiresBloc extends Bloc<WiresEvent, WiresState> {
  CopperWireData data = CopperWireData();
  WiresBloc() : super(WiresState()) {
    on<InitalGetData>(_initalGetData);
    on<Toggle>(_toggle);
    on<Search>(_search);
    on<SelectedRowColumn>(_selectedRowColumn);
    add(InitalGetData(heading: WireLogic().headings[0], isCopper: true));
  }

  FutureOr<void> _toggle(Toggle event, Emitter<WiresState> emit) {
    emit(state.copyWith(isCopper: event.isTrue));
    add(InitalGetData(isCopper: state.isCopper, heading: state.heading));
  }

  FutureOr<void> _search(Search event, Emitter<WiresState> emit) {
    if (event.value.isEmpty && event.heading.isEmpty) {
      add(InitalGetData(isCopper: state.isCopper, heading: state.heading));
    } else {
      final value = event.value.isNotEmpty ? event.value : state.value;
      final heading = event.heading.isNotEmpty ? event.heading : state.heading;
      if (value.isEmpty || heading.isEmpty) {
        emit(
          state.copyWith(
            value: value,
            heading: heading,
            wireGage: data.wireGauge,
            diameterMM: data.diameterMm,
            diameterInch: data.diameterInch,
            areaMM2: data.areaMm2,
            maxAmpere: ((state.isCopper) ? data.maxAmpereCopper : data.maxAmpereSilver),
            lengthMeterPerKg: ((state.isCopper)
                ? data.lengthMeterPerKgCopper
                : data.lengthMeterPerKgSilver),
          ),
        );
      } else {
        final map = WireLogic.filteredList(value, heading, data);

        emit(
          state.copyWith(
            value: value,
            heading: heading,
            wireGage: map['wireGages'] as List<String>,
            diameterMM: map['diameterMM'] as List<double>,
            diameterInch: map['diameterInch'] as List<double>,
            areaMM2: map['areaMm2'] as List<double>,
            maxAmpere: map['maxAmpere'] as List<double>,
            lengthMeterPerKg: map['lengthMeterPerKgs'] as List<double>,
          ),
        );
      }
    }
  }

  FutureOr<void> _selectedRowColumn(SelectedRowColumn event, Emitter<WiresState> emit) {
    emit(state.copyWith(selectedRow: event.row, selectedColumn: event.column));
  }

  FutureOr<void> _initalGetData(InitalGetData event, Emitter<WiresState> emit) {
    emit(
      WiresState(
        areaMM2: data.areaMm2,
        diameterInch: data.diameterInch,
        diameterMM: data.diameterMm,
        isCopper: event.isCopper,
        heading: event.heading,
        isSearch: false,
        lengthMeterPerKg: ((event.isCopper) ? data.lengthMeterPerKgCopper : data.maxAmpereSilver),
        maxAmpere: ((event.isCopper) ? data.maxAmpereCopper : data.maxAmpereSilver),
        selectedColumn: -1,
        selectedRow: -1,
        wireGage: data.wireGauge,
      ),
    );
  }
}
