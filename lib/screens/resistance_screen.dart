import 'package:circuitpedia/blocs/bloc/resistor_bloc.dart';
import 'package:circuitpedia/logic/resistor_logcs.dart';
import 'package:circuitpedia/screens/widgets/app_resistor_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResistanceScreen extends StatelessWidget {
  ResistanceScreen({super.key});
  void navigator(BuildContext context, int i, String name, bool isfourColuors) {
    context.read<ResistorBloc>().add(
      SetResisterColors(posstion: i, colorName: name, isfourColuors: true),
    );
  }

  final ResistorLogcs resistorLogcs = ResistorLogcs();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Resistor"), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: BlocBuilder<ResistorBloc, ResistorState>(
            builder: (context, state) {
              return Column(
                spacing: 10,
                children: [
                  SizedBox(
                    child: AppResistorWidget(
                      pContext: context,
                      colorsNames: state.colorsName4,
                    ),
                  ),
                  Text(state.result4, style: TextStyle(fontSize: 22)),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: DropdownButton<String>(
                      value: state.result4.split(" ")[1],
                      icon: Icon(Icons.settings),
                      items: List.generate(resistorLogcs.ohmFactors.length, (
                        index,
                      ) {
                        List symbols = resistorLogcs.ohmFactors.keys.toList();
                        return DropdownMenuItem<String>(
                          value: symbols[index],
                          child: Text(
                            "${resistorLogcs.symbolToName[symbols[index]]} ${symbols[index]}",

                            style: TextStyle(
                              fontSize: 20.r,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        );
                      }),
                      onChanged: (value) {
                        context.read<ResistorBloc>().add(Convert(value ?? "Ω"));
                      },
                    ),
                  ),
                  SizedBox(
                    child: AppResistorWidget(
                      pContext: context,
                      colorsNames: state.colorsName5,
                    ),
                  ),
                  Text(state.result5),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
