import 'package:circuitpedia/blocs/wires/wires_bloc.dart';
import 'package:flutter/gestures.dart';
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
  final List<String> headings = [
    "WireGage",
    "Diameter mm",
    "Diameter Inch",
    "Area mm2",
    "Max Ampere",
    "lengthMeterPerKg",
  ];
  @override
  void initState() {
    super.initState();

    headerHorizontalController.addListener(() {
      if (bodyHorizontalController.hasClients &&
          bodyHorizontalController.offset != headerHorizontalController.offset) {
        bodyHorizontalController.jumpTo(headerHorizontalController.offset);
      }
    });

    bodyHorizontalController.addListener(() {
      if (headerHorizontalController.hasClients &&
          headerHorizontalController.offset != bodyHorizontalController.offset) {
        headerHorizontalController.jumpTo(bodyHorizontalController.offset);
      }
    });

    firstColumnVerticalController.addListener(() {
      if (bodyVerticalController.hasClients &&
          bodyVerticalController.offset != firstColumnVerticalController.offset) {
        bodyVerticalController.jumpTo(firstColumnVerticalController.offset);
      }
    });

    bodyVerticalController.addListener(() {
      if (firstColumnVerticalController.hasClients &&
          firstColumnVerticalController.offset != bodyVerticalController.offset) {
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
            spacing: 20,
            children: [
              // SEARCH
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 180,
                      child: SearchBar(
                        hintText: 'Search...',
                        onChanged: (value) {
                          context.read<WiresBloc>().add(Search(value: value));
                        },
                      ),
                    ),
                    DropdownButton(
                      value: (state.heading.isEmpty) ? headings[0] : state.heading,
                      items: headings
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
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
                                headings[0],
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              controller: headerHorizontalController,

                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  headerCell(headings[1]),
                                  headerCell(headings[2]),
                                  headerCell(headings[3]),
                                  headerCell(headings[4]),
                                  headerCell(headings[5]),
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
                                return Container(
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: state.selectedRow == row && state.selectedRow != -1
                                        ? Colors.blue.shade200
                                        : null,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    state.wireGage[row],
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                );
                              },
                            ),
                          ),

                          Expanded(
                            child: SingleChildScrollView(
                              controller: bodyVerticalController,

                              child: SingleChildScrollView(
                                controller: bodyHorizontalController,
                                scrollDirection: Axis.horizontal,

                                child: SizedBox(
                                  width: columnWidth * 5,
                                  child: Table(
                                    border: TableBorder.all(),

                                    columnWidths: const {
                                      0: FixedColumnWidth(columnWidth),
                                      1: FixedColumnWidth(columnWidth),
                                      2: FixedColumnWidth(columnWidth),
                                      3: FixedColumnWidth(columnWidth),
                                      4: FixedColumnWidth(columnWidth),
                                    },

                                    children: [
                                      for (int row = 0; row < state.wireGage.length; row++)
                                        TableRow(
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
                                    ],
                                  ),
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
        state.selectedColumn == column && state.selectedRow != -1 && state.selectedColumn != -1;

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
        child: Text(value, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
