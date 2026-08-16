import 'package:circuitpedia/core/constants/app_icons.dart';
import 'package:circuitpedia/core/routes/app_routes.dart';
import 'package:circuitpedia/screens/widgets/app_button.dart';
import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(title: Text("Electronic")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200 ),

            children: [

                 AppButton(
                  imgPath: AppIcons.resistorIcons,
                  name: "Resistance",
                  namePage: AppRoutes.resistanceScreen,
                ),
              // Expanded(
              //   child: AppButton(
              //     imgPath: "",
              //     name: "Capacitor",
              //     namePage: AppRoutes.resistanceScreen,
              //   ),
              // ),
              // Expanded(
              //   child: AppButton(imgPath: "", name: "SMD", namePage: AppRoutes.resistanceScreen),
              // ),
              // Expanded(
              //   child: AppButton(
              //     imgPath: "",
              //     name: "Transformer",
              //     namePage: AppRoutes.resistanceScreen,
              //   ),
              // ),
              // Expanded(
              //   child: AppButton(imgPath: "", name: "UPS", namePage: AppRoutes.resistanceScreen),
              // ),
              // Expanded(
              //   child: AppButton(
              //     imgPath: "",
              //     name: "Circuts",
              //     namePage: AppRoutes.resistanceScreen,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
