import 'package:circuitpedia/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ResistorsScreen extends StatelessWidget {
  const ResistorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.w100);
    return Scaffold(
      appBar: AppBar(title: Text("Resistor")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 15,
            children: [
              SizedBox(width: double.infinity.w),
              Text("Value from colors.",style: textStyle,),
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
              SizedBox(height: 10,),
              Text("Colors from value.",style: textStyle,),
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
            ],
          ),
        ),
      ),
    );
  }
}
