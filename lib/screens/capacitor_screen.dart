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
    TextStyle textStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.w500);
    String symbol = "pF";
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
                          SizedBox(
                            width: 350.w,
                            height: 350.h,
                            child: Stack(
                              alignment: AlignmentGeometry.topCenter,
                              children: [Image.asset(AppIcons.polyesterIcons)],
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 100.w,
                            bottom: 1.h,
                            child: Image.asset(AppIcons.ceramicIcons),
                          ),
                          Positioned(
                            right: 40.w,
                            top: 60.h,
                            child: Text(state.code, style: textStyle),
                          ),
                          Positioned(
                            left: 100.w,
                            top: 120.h,
                            child: Text(state.code, style: textStyle),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 150.r,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        style: textStyle,
                        decoration: InputDecoration(
                          hintText: "101",
                          labelText: "Enter Code.",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.r)),
                        ),

                        onChanged: (value) {
                          context.read<CapacitorBloc>().add(SetCode(data: value));
                        },
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            spacing: 10,
                            children: [
                              SizedBox(
                                width: 200.r,

                                child: TextFormField(
                                  style: textStyle,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: "1000",
                                    labelText: "Enter Value.",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50.r),
                                    ),
                                  ),

                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      context.read<CapacitorBloc>().add(
                                        SetValue(data: "$value $symbol"),
                                      );
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
                                    if (state.value.isNotEmpty) {
                                      context.read<CapacitorBloc>().add(
                                        SetValue(data: "${state.value.split(" ")[0]} $value"),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
