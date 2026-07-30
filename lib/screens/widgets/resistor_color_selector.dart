import 'package:circuitpedia/blocs/bloc/resistor_bloc.dart';
import 'package:circuitpedia/logic/resistor_logcs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ResistorColorSelector extends StatelessWidget {
  ResistorColorSelector({
    super.key,
    required this.oldName,
    required this.pContext,
    required this.index,
    required this.isFour,
  });
  final ResistorLogcs resistorLogcs = ResistorLogcs();
  final String oldName;
  final BuildContext pContext;
  final int index;
  final bool isFour;
  @override
  Widget build(BuildContext context) {
    final List<String> colorsName = resistorLogcs.colorsValue.keys.toList();
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 500,
          child: GridView.builder(
            itemBuilder: (context, i) {
              return SizedBox(
                child: InkWell(
                  onTap: () {
                    pContext.read<ResistorBloc>().add(
                      SetResisterColors(
                        posstion: index,
                        colorName: colorsName[i],
                        isfourColuors: isFour,
                      ),
                    );
                    context.pop();
                  },
                  child: Card(
                    color: Colors.transparent,
                    shape: Border.all(
                      color: (oldName == colorsName[i])
                          ? Colors.blue
                          : Colors.black,
                      width: 1,
                    ),
                    child: Container(
                      color: resistorLogcs.getColor(colorsName[i]),
                      child: Center(
                        child: Text(
                          colorsName[i],
                          style: TextStyle(
                            color: (i == 2) ? Colors.white : Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: colorsName.length,
          ),
        ),
      ),
    );
  }
}
