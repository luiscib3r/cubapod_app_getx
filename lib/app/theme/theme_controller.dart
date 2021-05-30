import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();

  SharedPreferences storage;

  ThemeController({
    required this.storage,
  });

  @override
  onInit() {
    getThemeModeFromPreferences();
    super.onInit();
  }

  late ThemeMode _themeMode;
  ThemeMode get themeMode => _themeMode;

  Future<void> setThemeMode(ThemeMode themeMode) async {
    Get.changeThemeMode(themeMode);
    _themeMode = themeMode;
    update();

    await storage.setString('theme', themeMode.toString().split('.')[1]);
  }

  getThemeModeFromPreferences() {
    ThemeMode themeMode;
    String themeText = storage.getString('theme') ?? 'system';
    try {
      themeMode =
          ThemeMode.values.firstWhere((e) => describeEnum(e) == themeText);
    } catch (e) {
      print('MMM');
      themeMode = ThemeMode.system;
    }
    setThemeMode(themeMode);
  }
}
