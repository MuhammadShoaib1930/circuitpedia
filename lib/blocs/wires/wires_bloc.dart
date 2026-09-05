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
    on<WireType>(_wireType);
    on<Search>(_search);
    on<SelectedRowColumn>(_selectedRowColumn);
    add(InitalGetData(heading: WireLogic.headings[0], wireType: "Copper"));
  }

  FutureOr<void> _wireType(WireType event, Emitter<WiresState> emit) {
    emit(state.copyWith(wireType: event.wireType));
    if (state.value.isEmpty) {
      add(InitalGetData(wireType: state.wireType, heading: state.heading));
    } else {
      add(Search(heading: state.heading, value: state.value));
    }
  }

  FutureOr<void> _search(Search event, Emitter<WiresState> emit) {
    if (event.value.isEmpty && event.heading.isEmpty) {
      add(InitalGetData(wireType: state.wireType, heading: state.heading));
    } else {
      final value = event.value.isNotEmpty ? event.value : state.value;
      final heading = event.heading.isNotEmpty ? event.heading : state.heading;
      if (value.isEmpty || heading.isEmpty) {
        emit(
          state.copyWith(
            value: value,
            heading: heading,
            wireGauge: data.wireGauge,
            diameterMM: data.diameterMm,
            diameterInch: data.diameterInch,
            areaMM2: data.areaMm2,
            maxAmpere: CopperWireData().getWireData(state.wireType, true),
            lengthMeterPerKg: CopperWireData().getWireData(state.wireType, false),
          ),
        );
      } else {
        final map = WireLogic.filteredList(value, heading, state.wireType);
        List<String> headingNames = WireLogic.headings;
        emit(
          state.copyWith(
            value: value,
            heading: heading,
            wireGauge: map[headingNames[0]] as List<String>,
            diameterMM: map[headingNames[1]] as List<double>,
            diameterInch: map[headingNames[2]] as List<double>,
            areaMM2: map[headingNames[3]] as List<double>,
            maxAmpere: map[headingNames[4]] as List<double>,
            lengthMeterPerKg: map[headingNames[5]] as List<double>,
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
        wireType: event.wireType,
        heading: event.heading,
        isSearch: false,
        lengthMeterPerKg: CopperWireData().getWireData(event.wireType, false),
        maxAmpere: CopperWireData().getWireData(event.wireType, true),
        selectedColumn: -1,
        selectedRow: -1,
        wireGauge: data.wireGauge,
      ),
    );
  }
}
