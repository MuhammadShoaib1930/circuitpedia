import 'package:circuitpedia/blocs/smd_resistor/smd_resistor_bloc.dart';
import 'package:circuitpedia/core/constants/app_icons.dart';
import 'package:circuitpedia/logic/resistor_data.dart';
import 'package:circuitpedia/logic/resistor_logcs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmdResistorScreen extends StatelessWidget {
  const SmdResistorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String value = "0";
    String symbol = "Ω";
    final TextStyle textStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
    return Scaffold(
      appBar: AppBar(title: Text("SMD Resistor"), centerTitle: true),
      body: SafeArea(
        child: SizedBox(
          child: BlocBuilder<SmdResistorBloc, SmdResistorState>(
            builder: (context, state) {
              return Stack(
                alignment: AlignmentGeometry.topCenter,
                children: [
                  SizedBox(height: 350, width: 350.w),
                  Positioned(top: 1, child: Image.asset(AppIcons.smdResistorIcon)),
                  Positioned(
                    top: 80,
                    child: SizedBox(
                      width: 250,
                      child: TextFormField(
                        style: textStyle.copyWith(color: Colors.white),
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        decoration: InputDecoration(
                          hintText: "101",
                          labelText: "Enter Code. 101",
                          border: OutlineInputBorder(),
                        ),

                        onChanged: (code) {
                          if (code.isEmpty) {
                            context.read<SmdResistorBloc>().add(CodeToValue(code: "0"));
                          } else {
                            context.read<SmdResistorBloc>().add(CodeToValue(code: code));
                          }
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    child: Text(state.code, style: textStyle.copyWith(color: Colors.white)),
                  ),
                  Positioned(top: 200, child: Text(state.value, style: textStyle)),
                  Positioned(
                    top: 250,
                    child: Row(
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
                                  maxLength: (value.contains("."))
                                      ? 5
                                      : ((symbol == "Ω")
                                            ? 12
                                            : (symbol == "kΩ")
                                            ? 9
                                            : (symbol == "MΩ")
                                            ? 6
                                            : 3),
                                  decoration: InputDecoration(
                                    hintText: "1000",
                                    labelText: "Enter Value.",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50.r),
                                    ),
                                  ),

                                  onChanged: (newValue) {
                                    value = newValue;
                                    context.read<SmdResistorBloc>().add(
                                      ValueToCode(value: "$newValue $symbol"),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                child: DropdownMenu(
                                  textStyle: textStyle,
                                  dropdownMenuEntries: ResistorLogcs.smdUnits().map((e) {
                                    return DropdownMenuEntry(value: e, label: e);
                                  }).toList(),
                                  initialSelection: symbol,

                                  onSelected: (newSymbol) {
                                    if (newSymbol != null) {
                                      symbol = newSymbol;
                                    }

                                    context.read<SmdResistorBloc>().add(
                                      ValueToCode(value: "$value $symbol"),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
