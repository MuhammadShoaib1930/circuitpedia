import 'package:circuitpedia/blocs/bloc/resistor_bloc.dart';
import 'package:circuitpedia/screens/capacitor_screen.dart';
import 'package:circuitpedia/screens/resistors_screen.dart';
import 'package:circuitpedia/screens/smd_screen.dart';
import 'package:circuitpedia/screens/transformer_screen.dart';
import 'package:circuitpedia/screens/ups_screen.dart';
import 'package:circuitpedia/screens/widgets/resistor_widget.dart';
import 'package:circuitpedia/screens/widgets/resistor_widget_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../screens/home_screen.dart';

class AppRoutes {
  // screen Navigator names
  static const String homeScreen = "/home_screen";
  static const String resistanceScreen = "/resistance_screen";
  static const String capacitorScreen = "/capacitor_screen";
  static const String smdScreen = "/smd_screen";
  static const String transformerScreen = "/transformer_screen";
  static const String upsScreen = "/ups_screen";
  static const String circutsScreen = "/circuts_screen";

  // widget Navigator names
  static const String resistorWidget = "/resistor_widget";
  static const String resistorWidgetValue = "/resistor_widget_value";

  static GoRouter routes = GoRouter(
    initialLocation: homeScreen,

    routes: [
      // screen Navigator
      GoRoute(path: homeScreen, builder: (context, state) => HomeScreen()),
      GoRoute(path: resistanceScreen, builder: (context, state) => ResistorsScreen()),
      GoRoute(path: capacitorScreen, builder: (context, state) => CapacitorScreen()),
      GoRoute(path: smdScreen, builder: (context, state) => SmdScreen()),
      GoRoute(path: transformerScreen, builder: (context, state) => TransformerScreen()),
      GoRoute(path: upsScreen, builder: (context, state) => UpsScreen()),
      GoRoute(path: circutsScreen, builder: (context, state) => CircleAvatar()),
      // widget Navigator
      GoRoute(
        path: resistorWidget,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => ResistorBloc(),
            child: ResistorWidget(band: state.extra as int),
          );
        },
      ),
      GoRoute(
        path: resistorWidgetValue,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => ResistorBloc(),
            child: ResistorWidgetValue(band: state.extra as int),
          );
        },
      ),
    ],
  );
}
