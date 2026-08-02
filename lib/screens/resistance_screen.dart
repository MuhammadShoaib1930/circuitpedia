import 'package:circuitpedia/blocs/bloc/resistor_bloc.dart';
import 'package:circuitpedia/logic/resistor_logcs.dart';
import 'package:circuitpedia/screens/widgets/app_resistor_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResistanceScreen extends StatelessWidget {
  ResistanceScreen({super.key});
  void navigator(BuildContext context, int i, int index, bool isFour) {
    context.read<ResistorBloc>().add(SetResisterColors(position: i, index: index, isFour: isFour));
  }

  final ResistorLogcs resistorLogcs = ResistorLogcs();
  final TextEditingController textEditingController4 = TextEditingController();
  final TextEditingController textEditingController5 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Resistor"), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: BlocBuilder<ResistorBloc, ResistorState>(
            builder: (context, state) {
              textEditingController4.text = state.resistorModel4.resultValue.toString();
              return Column(
                spacing: 10,
                children: [
                  SizedBox(
                    child: AppResistorWidget(
                      pContext: context,
                      resistorModel: state.resistorModel4,
                    ),
                  ),
                  SizedBox(
                    width: 300.r,
                    height: 100.r,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 100.r,
                          height: 90,
                          child: TextField(
                            controller: textEditingController4,
                            keyboardType: TextInputType.numberWithOptions(signed: false,decimal: true),
                            decoration: InputDecoration(border: OutlineInputBorder()),
                          ),
                        ),

                        DropdownButton<String>(
                          borderRadius: BorderRadius.circular(10.r),

                          value: state.resistorModel4.resultsymbol,
                          items: List.generate(Data.symbolToUnits.length, (index) {
                            List symbols = Data.symbolToName.keys.toList();

                            return DropdownMenuItem<String>(
                              value: symbols[index],
                              child: Text(
                                "${symbols[index]}",
                                style: TextStyle(fontSize: 22.r, fontWeight: FontWeight.normal),
                              ),
                            );
                          }),
                          onChanged: (value) {
                            context.read<ResistorBloc>().add(Convert(value ?? "Ω"));
                          },
                        ),
                        DropdownButton<int>(
                          value: state.resistorModel4.resistor4Index,
                          items: Data.resistorPersentage.entries.map((entry) {
                            return DropdownMenuItem<int>(
                              value: entry.key,
                              child: Text(entry.value),
                            );
                          }).toList(),
                          onChanged: (value) {},
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
