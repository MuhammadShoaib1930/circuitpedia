import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';

import '../models/app_settings.dart';

class HiveService {
  static final _instance = HiveService._internal();
  HiveService._internal();
  factory HiveService() => _instance;

  final String settingBoxName = "settingBox";
  final String sudokuBoxName = "sudokuModel";
  final String magicSquareBoxName = "magicSquare";
  final String stroopBoxName = "stroopModel";

  late Box<AppSettings> settingBox;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(AppSettingsAdapter());
    await openBoxes();
  }

  Future<void> openBoxes() async {
    settingBox = await Hive.openBox<AppSettings>(settingBoxName);
  }

  T getDataFormBox<T>({required Box<T> box}) {
    // if (T == AppSettings) {
    return box.get(settingBoxName) ??
        AppSettings(isDark: false, profileImagePath: "", userName: "Guest") as T;
    // }
  }

  void updateBoxData<T>({
    required Box<T> box,
    bool? isDark,
    String? profileImagePath,
    String? userName,
  }) {
    // if (T == AppSettings) {
    final data = getDataFormBox<T>(box: box) as AppSettings;
    box.put(
      settingBoxName,
      data.copyWith(isDark: isDark, profileImagePath: profileImagePath, userName: userName) as T,
    );
    // }
  }

  ValueListenable<Box<T>> getListenableAppSettingsFormBox<T>({required Box<T> box}) {
    // if (T == AppSettings) {
    return box.listenable();
    // }
  }

  bool isDark() {
    return getDataFormBox<AppSettings>(box: settingBox).isDark;
  }
}
