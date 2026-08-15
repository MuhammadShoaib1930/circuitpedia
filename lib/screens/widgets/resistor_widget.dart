import 'package:circuitpedia/blocs/bloc/resistor_bloc.dart';
import 'package:circuitpedia/core/constants/app_icons.dart';
import 'package:circuitpedia/logic/resistor_logcs.dart';
import 'package:circuitpedia/screens/widgets/resistor_color_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResistorWidget extends StatelessWidget {
  final int band;
  const ResistorWidget({super.key, required this.band});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Resistor"), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<ResistorBloc, ResistorState>(
            builder: (blocContext, state) {
              int n = state.names.length;
              return Column(
                children: [
                  SizedBox(
                    width: 350.w,
                    height: 350.h,
                    child: Stack(
                      alignment: AlignmentGeometry.center,
                      children: [
                        Image.asset(AppIcons.resistorIcon),
                        Positioned(
                          left: 70.w,
                          child: InkWell(
                            onTap: () {
                              String oldColor = (n > 0) ? state.names[0] : "None";

                              showDialog(
                                context: context,
                                builder: (context) => ResistorColorSelector(
                                  oldColor: oldColor,
                                  blocContext: blocContext,
                                  index: 0,
                                  band: band,
                                ),
                              );
                            },
                            child: Container(
                              width: 25.w,
                              height: 100.h,
                              decoration: BoxDecoration(
                                color: (n > 0)
                                    ? ResistorLogcs.color(state.names[0])
                                    : Colors.transparent,
                                border: Border.all(color: Colors.black, width: 1),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 115.w,
                          child: InkWell(
                            onTap: () {
                              String oldColor = (n > 1) ? state.names[1] : "None";

                              showDialog(
                                context: context,
                                builder: (context) => ResistorColorSelector(
                                  oldColor: oldColor,
                                  blocContext: blocContext,
                                  index: 1,
                                  band: band,
                                ),
                              );
                            },
                            child: Container(
                              width: 25.w,
                              height: 80.h,
                              decoration: BoxDecoration(
                                color: (n > 1)
                                    ? ResistorLogcs.color(state.names[1])
                                    : Colors.transparent,
                                border: Border.all(color: Colors.black, width: 1),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: (band == 4) ? 190 : 155.w,
                          child: InkWell(
                            onTap: () {
                              String oldColor = (n > 2) ? state.names[2] : "None";

                              showDialog(
                                context: context,
                                builder: (context) => ResistorColorSelector(
                                  oldColor: oldColor,
                                  blocContext: blocContext,
                                  index: 2,
                                  band: band,
                                ),
                              );
                            },
                            child: Container(
                              width: 25.w,
                              height: 80.h,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 1),
                                color: (n > 2)
                                    ? ResistorLogcs.color(state.names[2])
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          left: (band == 4) ? 250.w : 190.w,
                          child: InkWell(
                            onTap: () {
                              String oldColor = (n > 3) ? state.names[3] : "None";

                              showDialog(
                                context: context,
                                builder: (context) => ResistorColorSelector(
                                  oldColor: oldColor,
                                  blocContext: blocContext,
                                  index: 3,
                                  band: band,
                                ),
                              );
                            },
                            child: Container(
                              width: 25.w,
                              height: (band == 4) ? 100.h : 80.h,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 1),
                                color: (n > 3)
                                    ? ResistorLogcs.color(state.names[3])
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                        if (band != 4)
                          Positioned(
                            left: (band == 5) ? 250.w : 210.w,
                            child: InkWell(
                              onTap: () {
                                String oldColor = (n > 4) ? state.names[4] : "None";

                                showDialog(
                                  context: context,
                                  builder: (context) => ResistorColorSelector(
                                    oldColor: oldColor,
                                    blocContext: blocContext,
                                    index: 4,
                                    band: band,
                                  ),
                                );
                              },
                              child: Container(
                                width: 25.w,
                                height: (band == 5) ? 100.h : 80.h,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black, width: 1),
                                  color: (n > 4)
                                      ? ResistorLogcs.color(state.names[4])
                                      : Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Text("${state.result} ${state.tolerance}"),
                  Text(state.formatValue),
                  Text("${state.minimum}"),
                  Text(" ${state.maximum}"),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
