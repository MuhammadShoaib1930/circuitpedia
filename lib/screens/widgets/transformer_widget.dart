import 'package:circuitpedia/blocs/transformer/transformer_bloc.dart';
import 'package:circuitpedia/core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransformerWidget {
  final TextStyle textStyle;
  final BuildContext context;
  const TransformerWidget(this.context, this.textStyle);

  SizedBox upsScreen() {
    return SizedBox(
      child: SingleChildScrollView(
        child: Column(
          spacing: 10.h,
          children: [
            SizedBox(width: double.infinity.w),
            Text("UPS Calculate", style: textStyle.copyWith(fontWeight: FontWeight.bold)),
            upsPageWidget(
              callBack1: (newValue) {
                if (newValue.isNotEmpty) {
                  context.read<TransformerBloc>().add(SetHeight(height: double.parse(newValue)));
                }
              },
              lable1: "WIDTH",
              callBack2: (newValue) {
                if (newValue.isNotEmpty) {
                  context.read<TransformerBloc>().add(SetWidth(width: double.parse(newValue)));
                }
              },
              lable2: "HEIGHT",
              callBack3: (newValue) {
                if (newValue.isNotEmpty) {
                  context.read<TransformerBloc>().add(SetArea(area: double.parse(newValue)));
                }
              },
              lable3: "Area",
            ),
            SizedBox(
              child: BlocBuilder<TransformerBloc, TransformerState>(
                builder: (context, state) {
                  return Column(
                    spacing: 10.h,
                    children: [
                      Text("v = Voltage  t = Turn", style: textStyle),
                      Text("p0 = ${state.pv[0]}v   ${state.pt[0]}t", style: textStyle),
                      Text("p1 = ${state.pv[1]}v   ${state.pt[1]}t", style: textStyle),
                      Text("p2 = ${state.pv[2]}v   ${state.pt[2]}t", style: textStyle),
                      Divider(),
                      Text("s0 = ${state.sv[0]}v   ${state.st[0]}t", style: textStyle),
                      Text("s1 = ${state.sv[1]}v   ${state.st[1]}t", style: textStyle),
                      Text("s2 = ${state.sv[2]}v   ${state.st[2]}t", style: textStyle),
                      Divider(),
                      Text("Area = ${state.area}", style: textStyle),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox upsPageWidget({
    String lable1 = "",
    String lable2 = "",
    String lable3 = "",
    required Function(String newValue) callBack1,
    required Function(String newValue) callBack2,
    required Function(String newValue) callBack3,
  }) {
    return SizedBox(
      child: Column(
        spacing: 10.h,
        children: [
          TextFormField(
            keyboardType: TextInputType.number,
            style: textStyle,
            onChanged: callBack1,
            decoration: InputDecoration(
              labelText: lable1,

              border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.r)),
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            style: textStyle,
            onChanged: callBack2,
            decoration: InputDecoration(
              labelText: lable2,

              border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.r)),
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            style: textStyle,
            onChanged: callBack3,
            decoration: InputDecoration(
              labelText: lable3,

              border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.r)),
            ),
          ),
          Stack(
            alignment: AlignmentGeometry.topCenter,
            children: [
              SizedBox(height: 190, width: double.infinity.w),
              Positioned(top: 40, child: Image.asset(AppIcons.transformerIcons)),
              Positioned(
                left: 20.w,
                top: 80.h,
                child: Text(
                  "output\nsecondary",
                  style: textStyle.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Positioned(
                left: 80.w,
                top: 20.h,
                child: Text("s1", style: textStyle),
              ),
              Positioned(
                left: 80.w,
                top: 50.h,
                child: Text("s2", style: textStyle),
              ),
              Positioned(
                left: 80.w,
                top: 140.h,
                child: Text("s3", style: textStyle),
              ),
              Positioned(
                right: 80.w,
                top: 40.h,
                child: Text("p1", style: textStyle),
              ),
              Positioned(
                right: 80.w,
                top: 75.h,
                child: Text("p2", style: textStyle),
              ),
              Positioned(
                right: 80.w,
                top: 120.h,
                child: Text("p3", style: textStyle),
              ),
              Positioned(
                left: 200.w,
                top: 10.h,
                child: Text(
                  "Input | primary",
                  style: textStyle.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Positioned(
                left: 40.w,
                top: 160.h,
                child: Text(
                  "s = secondary",
                  style: textStyle.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Positioned(
                right: 40.w,
                top: 160.h,
                child: Text("p = primary", style: textStyle.copyWith(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  SizedBox manualyScreen() {
    return SizedBox(
      child: BlocBuilder<TransformerBloc, TransformerState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              spacing: 10.h,
              children: [
                SizedBox(width: double.infinity.w),
                Text(
                  "Transformer Manualy Calculate",
                  style: textStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: state.height.toString(),
                  style: textStyle,
                  onChanged: (newvalue) {
                    if (newvalue.isNotEmpty) {
                      context.read<TransformerBloc>().add(
                        SetHeight(height: double.parse(newvalue)),
                      );
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "HEIGHT",

                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.r)),
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  initialValue: state.width.toString(),
                  onChanged: (newvalue) {
                    if (newvalue.isNotEmpty) {
                      context.read<TransformerBloc>().add(SetWidth(width: double.parse(newvalue)));
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "WIDTH",

                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.r)),
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  initialValue: state.area.toString(),
                  onChanged: (newvalue) {
                    if (newvalue.isNotEmpty) {
                      context.read<TransformerBloc>().add(SetArea(area: double.parse(newvalue)));
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Area",

                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.r)),
                  ),
                ),
                Text("Area = ${state.area.toString()}", style: textStyle),
                SizedBox(
                  width: double.infinity.w,
                  height: 400.h,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        child: Row(
                          children: [
                            SizedBox(
                              width: (state.model[index].isVoltage) ? 100.w : 130.w,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                style: textStyle,
                                initialValue: (state.model[index].isVoltage)
                                    ? state.model[index].truns.toString()
                                    : state.model[index].voltage.toString(),
                                maxLength: (state.model[index].isVoltage) ? 4 : 8,
                                onChanged: (newvalue) {
                                  if (newvalue.isNotEmpty) {
                                    if (state.model[index].isVoltage) {
                                      context.read<TransformerBloc>().add(
                                        SetTurns(turns: double.parse(newvalue), index: index),
                                      );
                                    } else {
                                      context.read<TransformerBloc>().add(
                                        SetVoltage(voltage: double.parse(newvalue), index: index),
                                      );
                                    }
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: (state.model[index].isVoltage) ? "Turns" : "Voltage",

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.r),
                                  ),
                                ),
                              ),
                            ),
                            Switch(
                              value: state.model[index].isVoltage,
                              onChanged: (value) {
                                context.read<TransformerBloc>().add(
                                  SetIsVoltage(isVoltage: value, index: index),
                                );
                              },
                            ),
                            Text(
                              (state.model[index].isVoltage)
                                  ? "Voltage = ${state.model[index].voltage}v"
                                  : "Truns = ${state.model[index].truns}t",
                              style: textStyle,
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: state.model.length,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  SizedBox transformerInfoScreen() {
    return SizedBox(
      child: BlocBuilder<TransformerBloc, TransformerState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              spacing: 10.h,
              children: [
                SizedBox(width: double.infinity.w),
                Text(
                  "Transformer information",
                  style: textStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  initialValue: state.area.toString(),
                  onChanged: (newvalue) {
                    if (newvalue.isNotEmpty) {
                      context.read<TransformerBloc>().add(SetArea(area: double.parse(newvalue)));
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Area",

                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.r)),
                  ),
                ),
                SizedBox(
                  width: double.infinity.w,
                  height: 400.h,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        child: Row(
                          children: [
                            SizedBox(
                              width: (state.model[index].isVoltage) ? 100.w : 130.w,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                style: textStyle,
                                initialValue: (state.model[index].isVoltage)
                                    ? state.model[index].truns.toString()
                                    : state.model[index].voltage.toString(),
                                maxLength: (state.model[index].isVoltage) ? 4 : 8,
                                onChanged: (newvalue) {
                                  if (newvalue.isNotEmpty) {
                                    if (state.model[index].isVoltage) {
                                      context.read<TransformerBloc>().add(
                                        SetTurns(turns: double.parse(newvalue), index: index),
                                      );
                                    } else {
                                      context.read<TransformerBloc>().add(
                                        SetVoltage(voltage: double.parse(newvalue), index: index),
                                      );
                                    }
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: (state.model[index].isVoltage) ? "Turns" : "Voltage",

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.r),
                                  ),
                                ),
                              ),
                            ),
                            Switch(
                              value: state.model[index].isVoltage,
                              onChanged: (value) {
                                context.read<TransformerBloc>().add(
                                  SetIsVoltage(isVoltage: value, index: index),
                                );
                              },
                            ),
                            Text(
                              (state.model[index].isVoltage)
                                  ? "Voltage = ${state.model[index].voltage}v"
                                  : "Truns = ${state.model[index].truns}t",
                              style: textStyle,
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: state.model.length,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
