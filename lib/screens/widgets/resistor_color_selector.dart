import 'package:circuitpedia/blocs/bloc/resistor_bloc.dart';
import 'package:circuitpedia/logic/resistor_logcs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ResistorColorSelector extends StatelessWidget {
  ResistorColorSelector({
    super.key,
    required this.oldIndex,
    required this.pContext,
    required this.position,
    required this.isFour,
    this.isPersentage = false,
    this.isPower = false,
    this.isValue = false,
  });
  final ResistorLogcs resistorLogcs = ResistorLogcs();
  final int oldIndex;
  final BuildContext pContext;
  final int position;
  final bool isFour;
  final bool isPersentage;
  final bool isPower;
  final bool isValue;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 500,
          child: GridView.builder(
            itemBuilder: (context, i) {
              bool isShow = true;
              if (isPersentage) {
                if (i == 2 || i == 5 || i == 6 || i == 10 || i == 11) {
                  isShow = false;
                }
              }
              if (isValue) {
                if (i == 0 || i == 1) {
                  isShow = false;
                }
              }
              return (isShow)
                  ? SizedBox(
                      child: InkWell(
                        onTap: () {
                          pContext.read<ResistorBloc>().add(
                            SetResisterColors(position: position, index: i),
                          );
                          context.pop();
                        },
                        child: Card(
                          color: Colors.transparent,
                          shape: Border.all(
                            color: (oldIndex == i) ? Colors.blue : Colors.black,
                            width: 2,
                          ),
                          child: Container(
                            color: Data.resistorColors[i],
                            child: Center(
                              child: Text(
                                Data.resistorNames[i],
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
                    )
                  : SizedBox();
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: Data.resistorNames.length,
          ),
        ),
      ),
    );
  }
}
