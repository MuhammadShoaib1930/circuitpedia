import 'package:circuitpedia/blocs/resistor/resistor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:circuitpedia/core/constants/app_icons.dart';
import 'package:circuitpedia/logic/resistor_logcs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResistorWidgetValue extends StatelessWidget {
  final int band;
  const ResistorWidgetValue({super.key, required this.band});
  @override
  Widget build(BuildContext context) {
    String? tolerance;
    final TextEditingController valueController = TextEditingController();
    TextStyle textStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    return Scaffold(
      appBar: AppBar(title: Text("Resistor value from colors"), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<ResistorBloc, ResistorState>(
            builder: (blocContext, state) {
              int n = state.names.length;
              return Column(
                spacing: 5.r,
                children: [
                  SizedBox(
                    width: 350.w,
                    height: 200.h,
                    child: Stack(
                      alignment: AlignmentGeometry.center,
                      children: [
                        Image.asset(AppIcons.resistorIcon),
                        Positioned(
                          left: 70.w,
                          child: Container(
                            width: 25.w,
                            height: 100.h,
                            color: (n > 0)
                                ? ResistorLogcs.color(state.names[0])
                                : Colors.transparent,
                          ),
                        ),
                        Positioned(
                          left: 115.w,
                          child: Container(
                            width: 25.w,
                            height: 80.h,
                            color: (n > 1)
                                ? ResistorLogcs.color(state.names[1])
                                : Colors.transparent,
                          ),
                        ),
                        Positioned(
                          left: (band == 4) ? 190 : 155.w,
                          child: Container(
                            width: 25.w,
                            height: 80.h,
                            color: (n > 2)
                                ? ResistorLogcs.color(state.names[2])
                                : Colors.transparent,
                          ),
                        ),

                        Positioned(
                          left: (band == 4) ? 250.w : 190.w,
                          child: Container(
                            width: 25.w,
                            height: (band == 4) ? 100.h : 80.h,
                            color: (n > 3)
                                ? ResistorLogcs.color(state.names[3])
                                : Colors.transparent,
                          ),
                        ),
                        if (band != 4)
                          Positioned(
                            left: (band == 5) ? 250.w : 210.w,
                            child: Container(
                              width: 25.w,
                              height: (band == 5) ? 100.h : 80.h,
                              color: (n > 4)
                                  ? ResistorLogcs.color(state.names[4])
                                  : Colors.transparent,
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 200,
                          child: TextFormField(
                            controller: valueController,
                            style: textStyle,

                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r)),
                            ),
                            maxLength: 11,
                            onChanged: (String value) {
                              if (value.isNotEmpty && double.parse(value) > 0) {
                                context.read<ResistorBloc>().add(
                                  ColorsFromValue(
                                    value: valueController.text.toString(),
                                    tolerance: tolerance ?? ResistorLogcs.allTolerances[0],
                                    band: band,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        DropdownMenu(
                          dropdownMenuEntries: ResistorLogcs.allTolerances.map((e) {
                            return DropdownMenuEntry(value: e, label: e);
                          }).toList(),
                          initialSelection: ResistorLogcs.allTolerances[0],

                          onSelected: (value) {
                            String v = valueController.text.toString();
                            if (v.isNotEmpty && double.parse(v) > 0) {
                              context.read<ResistorBloc>().add(
                                ColorsFromValue(
                                  value: valueController.text.toString(),
                                  tolerance: value ?? ResistorLogcs.allTolerances[0],
                                  band: band,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  Text("Value = ${state.result} ${state.tolerance}", style: textStyle),
                  Text("Or = ${state.formatValue}", style: textStyle),
                  Text("Minimum Range = ${state.minimum}", style: textStyle),
                  Text("Maximum Range = ${state.maximum}", style: textStyle),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
