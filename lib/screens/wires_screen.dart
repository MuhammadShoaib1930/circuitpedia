import 'package:circuitpedia/blocs/wires/wires_bloc.dart';
import 'package:circuitpedia/logic/wire_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WiresScreen extends StatefulWidget {
  const WiresScreen({super.key});

  @override
  State<WiresScreen> createState() => _WiresScreenState();
}

class _WiresScreenState extends State<WiresScreen> {
  final ScrollController headerHorizontalController = ScrollController();

  final ScrollController bodyHorizontalController = ScrollController();

  final ScrollController firstColumnVerticalController = ScrollController();

  final ScrollController bodyVerticalController = ScrollController();

  static const double firstColumnWidth = 100;
  static const double columnWidth = 100;

  @override
  void initState() {
    super.initState();

    headerHorizontalController.addListener(() {
      if (!bodyHorizontalController.hasClients) return;

      if (bodyHorizontalController.offset != headerHorizontalController.offset) {
        bodyHorizontalController.jumpTo(headerHorizontalController.offset);
      }
    });

    bodyHorizontalController.addListener(() {
      if (!headerHorizontalController.hasClients) return;

      if (headerHorizontalController.offset != bodyHorizontalController.offset) {
        headerHorizontalController.jumpTo(bodyHorizontalController.offset);
      }
    });

    firstColumnVerticalController.addListener(() {
      if (!bodyVerticalController.hasClients) return;

      if (bodyVerticalController.offset != firstColumnVerticalController.offset) {
        bodyVerticalController.jumpTo(firstColumnVerticalController.offset);
      }
    });

    bodyVerticalController.addListener(() {
      if (!firstColumnVerticalController.hasClients) return;

      if (firstColumnVerticalController.offset != bodyVerticalController.offset) {
        firstColumnVerticalController.jumpTo(bodyVerticalController.offset);
      }
    });
  }

  @override
  void dispose() {
    headerHorizontalController.dispose();
    bodyHorizontalController.dispose();
    firstColumnVerticalController.dispose();
    bodyVerticalController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WiresBloc, WiresState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${state.isCopper ? "Copper" : "Silver"} Wires',
                  style: const TextStyle(fontSize: 24),
                ),

                Switch(
                  value: state.isCopper,
                  onChanged: (value) {
                    context.read<WiresBloc>().add(Toggle(value));
                  },
                ),
              ],
            ),
            centerTitle: true,
          ),

          body: Column(
            children: [
              SizedBox(height: 10.h),
              Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100.w,
                      child: SearchBar(
                        hintText: 'Search...',

                        onChanged: (value) {
                          context.read<WiresBloc>().add(Search(value: value));
                        },
                      ),
                    ),
                    SizedBox(width: 10),

                    DropdownButton<String>(
                      value: state.heading.isEmpty ? WireLogic().headings[0] : state.heading,

                      items: WireLogic().headings
                          .map(
                            (e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(e, style: TextStyle(fontSize: 18)),
                            ),
                          )
                          .toList(),

                      onChanged: (heading) {
                        if (heading != null) {
                          context.read<WiresBloc>().add(Search(heading: heading));
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(border: Border.all()),
                      child: Row(
                        children: [
                          SizedBox(
                            width: firstColumnWidth,
                            child: Container(
                              height: 50.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(border: Border.all()),
                              child: Text(
                                WireLogic().headings[0],
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),

                          Expanded(
                            child: SingleChildScrollView(
                              controller: headerHorizontalController,
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  headerCell(WireLogic().headings[1]),
                                  headerCell(WireLogic().headings[2]),
                                  headerCell(WireLogic().headings[3]),
                                  headerCell(WireLogic().headings[4]),
                                  headerCell(WireLogic().headings[5]),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(
                            width: firstColumnWidth,
                            child: ListView.builder(
                              controller: firstColumnVerticalController,

                              itemCount: state.wireGage.length,

                              itemBuilder: (context, row) {
                                final bool selected =
                                    state.selectedRow == row && state.selectedRow != -1;

                                return Container(
                                  width: firstColumnWidth,
                                  height: 50.h,
                                  alignment: Alignment.center,

                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: selected ? Colors.blue.shade200 : null,
                                  ),

                                  child: Text(
                                    state.wireGage[row],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                );
                              },
                            ),
                          ),

                          Expanded(
                            child: SingleChildScrollView(
                              controller: bodyHorizontalController,

                              scrollDirection: Axis.horizontal,

                              child: SizedBox(
                                width: columnWidth * 5,

                                child: ListView.builder(
                                  controller: bodyVerticalController,

                                  itemCount: state.wireGage.length,

                                  itemBuilder: (context, row) {
                                    return SizedBox(
                                      height: 50.h,

                                      child: Row(
                                        children: [
                                          cell(
                                            state.diameterMM[row].toString(),
                                            row,
                                            1,
                                            state,
                                            context,
                                          ),

                                          cell(
                                            state.diameterInch[row].toString(),
                                            row,
                                            2,
                                            state,
                                            context,
                                          ),

                                          cell(
                                            state.areaMM2[row].toString(),
                                            row,
                                            3,
                                            state,
                                            context,
                                          ),

                                          cell(
                                            state.maxAmpere[row].toString(),
                                            row,
                                            4,
                                            state,
                                            context,
                                          ),

                                          cell(
                                            state.lengthMeterPerKg[row].toString(),
                                            row,
                                            5,
                                            state,
                                            context,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget headerCell(String value) {
    return Container(
      width: columnWidth,
      height: 50.h,
      alignment: Alignment.center,

      decoration: BoxDecoration(border: Border.all()),

      child: Text(
        value,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget cell(String value, int row, int column, WiresState state, BuildContext context) {
    final bool selected =
        state.selectedRow == row ||
        (state.selectedColumn == column && state.selectedRow != -1 && state.selectedColumn != -1);

    return GestureDetector(
      onTap: () {
        if (state.selectedRow == row && state.selectedColumn == column) {
          context.read<WiresBloc>().add(SelectedRowColumn(row: -1, column: -1));
        } else {
          context.read<WiresBloc>().add(SelectedRowColumn(row: row, column: column));
        }
      },

      child: Container(
        width: columnWidth,
        height: 50.h,
        alignment: Alignment.center,

        decoration: BoxDecoration(
          border: Border.all(),
          color: selected ? Colors.blue.shade200 : null,
        ),

        child: Text(value, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
