import 'package:circuitpedia/blocs/resistor/resistor_bloc.dart';
import 'package:circuitpedia/logic/resistor_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ResistorColorSelector extends StatelessWidget {
  final String oldColor;
  final BuildContext blocContext;
  final int index;
  final int band;
  const ResistorColorSelector({
    super.key,
    required this.oldColor,
    required this.blocContext,
    required this.index,
    required this.band,
  });
  bool isShowColor(String name, int i) {
    if ((name == "Silver" || name == "Gold") && (i == 0 || i == 1)) {
      return false;
    } else if (band == 5 && (name == "Silver" || name == "Gold") && (i == 0 || i == 1 || i == 2)) {
      return false;
    }
    if (name == "Black" ||
        name == "Orange" ||
        name == "Yellow" ||
        name == "Grey" ||
        name == "White") {
      if (band == 4 && i == 3) {
        return false;
      } else if (band == 5 && i == 4) {
        return false;
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 500,
          child: GridView.builder(
            itemBuilder: (context, i) {
              final List<String> keys = ResistorData.colors.keys.toList();

              return (isShowColor(keys[i], index))
                  ? SizedBox(
                      child: InkWell(
                        onTap: () {
                          blocContext.read<ResistorBloc>().add(
                            SetIndexColors(index: index, name: keys[i]),
                          );
                          context.pop();
                        },
                        child: Card(
                          color: Colors.transparent,
                          shape: Border.all(
                            color: (keys[i] == oldColor) ? Colors.blue : Colors.black,
                            width: 2,
                          ),
                          child: Container(
                            color: ResistorData.colors[keys[i]],
                            child: Center(
                              child: Text(
                                keys[i],
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
            itemCount: ResistorData.colors.length,
          ),
        ),
      ),
    );
  }
}
