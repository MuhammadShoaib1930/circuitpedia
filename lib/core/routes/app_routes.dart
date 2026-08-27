import 'package:circuitpedia/blocs/capacitor/capacitor_bloc.dart';
import 'package:circuitpedia/blocs/resistor/resistor_bloc.dart';
import 'package:circuitpedia/blocs/smd_resistor/smd_resistor_bloc.dart';
import 'package:circuitpedia/blocs/transformer/transformer_bloc.dart';
import 'package:circuitpedia/screens/capacitor_screen.dart';
import 'package:circuitpedia/screens/resistors_screen.dart';
import 'package:circuitpedia/screens/smd_resistor_screen.dart';
import 'package:circuitpedia/screens/transformer_screen.dart';
import 'package:circuitpedia/screens/widgets/resistor_widget_color.dart';
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
  static const String transformerScreen = "/transformer_screen";
  static const String circutsScreen = "/circuts_screen";
  static const String smdResistorScreen = "/smdResistor_screen";

  // widget Navigator names
  static const String resistorWidget = "/resistor_widget";
  static const String resistorWidgetValue = "/resistor_widget_value";

  static GoRouter routes = GoRouter(
    initialLocation: homeScreen,

    routes: [
      // screen Navigator
      GoRoute(path: homeScreen, builder: (context, state) => HomeScreen()),
      GoRoute(path: resistanceScreen, builder: (context, state) => ResistorsScreen()),
      GoRoute(
        path: capacitorScreen,
        builder: (context, state) =>
            BlocProvider(create: (context) => CapacitorBloc(), child: CapacitorScreen()),
      ),
      GoRoute(
        path: transformerScreen,
        builder: (context, state) =>
            BlocProvider(create: (context) => TransformerBloc(), child: TransformerScreen()),
      ),
      GoRoute(
        path: smdResistorScreen,
        builder: (context, state) =>
            BlocProvider(create: (context) => SmdResistorBloc(), child: SmdResistorScreen()),
      ),
      GoRoute(path: circutsScreen, builder: (context, state) => CircleAvatar()),
      // widget Navigator
      GoRoute(
        path: resistorWidget,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => ResistorBloc(),
            child: ResistorWidgetColor(band: state.extra as int),
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
