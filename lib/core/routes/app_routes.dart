import 'package:circuitpedia/blocs/bloc/resistor_bloc.dart';
import 'package:circuitpedia/screens/capacitor_screen.dart';
import 'package:circuitpedia/screens/resistance_screen.dart';
import 'package:circuitpedia/screens/smd_screen.dart';
import 'package:circuitpedia/screens/transformer_screen.dart';
import 'package:circuitpedia/screens/ups_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../screens/home_screen.dart';

class AppRoutes {
  static const String homeScreen = "/home_screen";
  static const String resistanceScreen = "/resistance_screen";
  static const String capacitorScreen = "/capacitor_screen";
  static const String smdScreen = "/smd_screen";
  static const String transformerScreen = "/transformer_screen";
  static const String upsScreen = "/ups_screen";
  static const String circutsScreen = "/circuts_screen";

  static GoRouter routes = GoRouter(
    initialLocation: homeScreen,
    routes: [
      GoRoute(path: homeScreen, builder: (context, state) => HomeScreen()),
      GoRoute(
        path: resistanceScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => ResistorBloc(),
          child: ResistanceScreen(),
        ),
      ),
      GoRoute(
        path: capacitorScreen,
        builder: (context, state) => CapacitorScreen(),
      ),
      GoRoute(path: smdScreen, builder: (context, state) => SmdScreen()),
      GoRoute(
        path: transformerScreen,
        builder: (context, state) => TransformerScreen(),
      ),
      GoRoute(path: upsScreen, builder: (context, state) => UpsScreen()),
      GoRoute(path: circutsScreen, builder: (context, state) => CircleAvatar()),
    ],
  );
}
