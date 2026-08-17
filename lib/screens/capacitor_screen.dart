import 'package:circuitpedia/blocs/capacitor/capacitor_bloc.dart';
import 'package:circuitpedia/core/constants/app_icons.dart';
import 'package:circuitpedia/logic/capacitor_logics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CapacitorScreen extends StatelessWidget {
  const CapacitorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? selected;
    String? data;
    TextStyle textStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
    return Scaffold(
      appBar: AppBar(title: Text("Capacitor"), centerTitle: true),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.all(10.r),
            child: BlocBuilder<CapacitorBloc, CapacitorState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: double.infinity.w),
                    SizedBox(
                      width: 350.w,
                      height: 350.h,
                      child: Stack(
                        alignment: AlignmentGeometry.bottomCenter,
                        children: [
                          Image.asset(AppIcons.ceramicIcons),
                          Positioned(
                            top: 80.r,
                            left: 134.r,
                            child: SizedBox(
                              width: 70,
                              height: 80,
                              child: TextFormField(
                                maxLength: 3,
                                style: textStyle,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.r),
                                  ),
                                ),
                                onChanged: (value) {
                                  if (value.isNotEmpty && value.length == 3) {
                                    context.read<CapacitorBloc>().add(
                                      CeramicCalculate(data: value, isCodeToValue: true),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          Text("Value = ${state.ceramicValue}", style: textStyle),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: TextFormField(
                        style: textStyle,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.r)),
                        ),

                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            context.read<CapacitorBloc>().add(
                              CeramicCalculate(data: value, isCodeToValue: false),
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 350.w,
                      height: 350.h,
                      child: Stack(
                        alignment: AlignmentGeometry.bottomCenter,
                        children: [
                          Image.asset(AppIcons.polyesterIcons),
                          Positioned(
                            top: 140.r,
                            left: 80.r,
                            child: SizedBox(
                              width: 80.r,
                              height: 150.r,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                maxLength: 3,
                                style: textStyle,
                                decoration: InputDecoration(border: OutlineInputBorder()),

                                onChanged: (value) {
                                  if (value.isNotEmpty && value.length == 3) {
                                    context.read<CapacitorBloc>().add(
                                      PolyesterCalculate(data: value, isCodeToValue: true),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          Text("Value = ${state.polyesterValue}", style: textStyle),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: textStyle,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.r)),
                        ),

                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            context.read<CapacitorBloc>().add(
                              PolyesterCalculate(data: value, isCodeToValue: false),
                            );
                          }
                        },
                      ),
                    ),
                    Text("Value to Code and Code to value", style: textStyle),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 200,
                            height: 60,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              style: textStyle,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.r),
                                ),
                              ),

                              onChanged: (value) {
                                if (double.parse(value) > 0) {
                                  data = value;
                                  if (selected != null) {
                                    context.read<CapacitorBloc>().add(
                                      ValueConvert(data: "$value $selected"),
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            child: DropdownMenu(
                              textStyle: textStyle,
                              dropdownMenuEntries: CapacitorLogics.units.keys.map((e) {
                                return DropdownMenuEntry(value: e, label: e);
                              }).toList(),
                              initialSelection: CapacitorLogics.units.keys.toList()[0],

                              onSelected: (value) {
                                if (value != null && value.isNotEmpty) {
                                  selected = value;

                                  if (data != null) {
                                    context.read<CapacitorBloc>().add(
                                      ValueConvert(data: "$data $value"),
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Column(
                        children: [
                          Text(state.toValue[0], style: textStyle),
                          Text(state.toValue[1], style: textStyle),
                          Text(state.toValue[2], style: textStyle),
                          Text(state.toValue[3], style: textStyle),
                          Text(state.toValue[4], style: textStyle),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
