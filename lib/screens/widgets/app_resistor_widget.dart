import 'package:circuitpedia/logic/resistor_logcs.dart';
import 'package:circuitpedia/models/resistor_model.dart';
import 'package:circuitpedia/screens/widgets/resistor_color_selector.dart';
import 'package:circuitpedia/services/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppResistorWidget extends StatelessWidget {
  final BuildContext pContext;
  final ResistorModel resistorModel;
  final bool isFour;
  final bool isDark = HiveService().isDark();
  AppResistorWidget({
    super.key,
    required this.pContext,
    required this.resistorModel,
    this.isFour = true,
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
          Positioned(left: 48, child: Container(color: Colors.grey, width: 257, height: 80)),
          Positioned(left: 0, child: Container(width: 50, height: 5, color: Colors.grey)),

          Positioned(
            left: (55),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => ResistorColorSelector(
                    oldIndex: resistorModel.resistor0Index,
                    pContext: pContext,
                    position: 0,
                    isFour: isFour,
                    isValue: true,
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Data.resistorColors[resistorModel.resistor0Index],
                  border: Border.all(color: Colors.white),
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
                    oldIndex: resistorModel.resistor1Index,
                    pContext: pContext,
                    position: 1,
                    isFour: isFour,
                    isValue: true,
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Data.resistorColors[resistorModel.resistor1Index],
                  border: Border.all(color: Colors.white),
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
                    oldIndex: resistorModel.resistor2Index,
                    pContext: pContext,
                    position: 2,
                    isFour: isFour,
                    isValue: (isFour) ? false : true,
                    isPower: (isFour) ? true : false,
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Data.resistorColors[resistorModel.resistor2Index],
                  border: Border.all(color: Colors.white),
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
                    oldIndex: resistorModel.resistor3Index,
                    pContext: pContext,
                    position: 3,
                    isFour: isFour,
                    isPower: (isFour) ? false : true,
                    isPersentage: (isFour) ? true : false,
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Data.resistorColors[resistorModel.resistor3Index],
                  border: Border.all(color: Colors.white),
                ),

                width: 45,
                height: 75,
              ),
            ),
          ),
          if (!isFour)
            Positioned(
              left: (255),
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => ResistorColorSelector(
                      oldIndex: resistorModel.resistor4Index,
                      pContext: pContext,
                      position: 4,
                      isFour: isFour,
                      isPersentage: true,
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Data.resistorColors[resistorModel.resistor4Index],
                    border: Border.all(color: Colors.white),
                  ),
                  width: 45,
                  height: 75,
                ),
              ),
            ),
          Positioned(left: 300, child: Container(width: 50, height: 5, color: Colors.grey)),
        ],
      ),
    );
  }
}
