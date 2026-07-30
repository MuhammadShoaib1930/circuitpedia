import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'my_app.dart';
import 'services/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService().init();
  await WakelockPlus.enable();
  runApp(const MyApp());
}
