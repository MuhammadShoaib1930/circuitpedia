import 'package:circuitpedia/logic/resistor_logcs.dart';
import 'package:circuitpedia/screens/widgets/resistor_color_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppResistorWidget extends StatelessWidget {
  final BuildContext pContext;
  final List<String> colorsNames;
  AppResistorWidget({
    super.key,
    required this.pContext,
    required this.colorsNames,
  });
  final ResistorLogcs resistorLogcs = ResistorLogcs();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350.w,
      height: 80.h,
      child: Stack(
        alignment: AlignmentGeometry.centerLeft,
        children: [
          Positioned(
            left: 48,
            child: Container(color: Colors.white, width: 257, height: 80),
          ),
          Positioned(
            left: 0,
            child: Container(width: 50, height: 5, color: Colors.white),
          ),

          Positioned(
            left: (55),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => ResistorColorSelector(
                    oldName: colorsNames[0],
                    pContext: pContext,
                    index: 0,
                    isFour: (colorsNames.length > 4) ? false : true,
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: resistorLogcs.getColor(colorsNames[0]),
                  border: Border.all(color: Colors.black),
                ),
                width: 45,
                height: 75,
              ),
            ),
          ),
          Positioned(
            left: (105),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => ResistorColorSelector(
                    oldName: colorsNames[1],
                    pContext: pContext,
                    index: 1,
                    isFour: (colorsNames.length > 4) ? false : true,
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: resistorLogcs.getColor(colorsNames[1]),
                  border: Border.all(color: Colors.black),
                ),
                width: 45,
                height: 75,
              ),
            ),
          ),
          Positioned(
            left: (155),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => ResistorColorSelector(
                    oldName: colorsNames[2],
                    pContext: pContext,
                    index: 2,
                    isFour: (colorsNames.length > 4) ? false : true,
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: resistorLogcs.getColor(colorsNames[2]),
                  border: Border.all(color: Colors.black),
                ),

                width: 45,
                height: 75,
              ),
            ),
          ),

          Positioned(
            left: (205),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => ResistorColorSelector(
                    oldName: colorsNames[3],
                    pContext: pContext,
                    index: 3,
                    isFour: (colorsNames.length > 4) ? false : true,
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: resistorLogcs.getColor(colorsNames[3]),
                  border: Border.all(color: Colors.black),
                ),

                width: 45,
                height: 75,
              ),
            ),
          ),
          if (colorsNames.length > 4)
            Positioned(
              left: (255),
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => ResistorColorSelector(
                      oldName: colorsNames[4],
                      pContext: pContext,
                      index: 4,
                      isFour: (colorsNames.length > 4) ? false : true,
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: resistorLogcs.getColor(colorsNames[4]),
                    border: Border.all(color: Colors.black),
                  ),
                  width: 45,
                  height: 75,
                ),
              ),
            ),
          Positioned(
            left: 300,
            child: Container(width: 50, height: 5, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
