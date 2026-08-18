import 'package:circuitpedia/core/constants/app_icons.dart';
import 'package:circuitpedia/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ResistorsScreen extends StatelessWidget {
  const ResistorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 22);
    return Scaffold(
      appBar: AppBar(title: Text("Resistor")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(width: double.infinity.w),
              Text("Value from colors.", style: textStyle),
              ElevatedButton(
                onPressed: () {
                  context.push(AppRoutes.resistorWidget, extra: 4);
                },
                child: Text("4 band", style: textStyle),
              ),
              ElevatedButton(
                onPressed: () {
                  context.push(AppRoutes.resistorWidget, extra: 5);
                },
                child: Text("5 band", style: textStyle),
              ),
              SizedBox(height: 10),
              Text("Colors from value.", style: textStyle),
              ElevatedButton(
                onPressed: () {
                  context.push(AppRoutes.resistorWidgetValue, extra: 4);
                },
                child: Text("4 band", style: textStyle),
              ),
              ElevatedButton(
                onPressed: () {
                  context.push(AppRoutes.resistorWidgetValue, extra: 5);
                },
                child: Text("5 band", style: textStyle),
              ),
              Text("SMD Resistor", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ElevatedButton(
                onPressed: () {
                  context.push(AppRoutes.smdResistorScreen, extra: 5);
                },
                child: Text("SMD Resistor", style: textStyle),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
