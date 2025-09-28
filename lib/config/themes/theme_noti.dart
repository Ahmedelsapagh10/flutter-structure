// lib/shared/theme/theme_notifier.dart

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:new_strucuture/core/preferences/flutter_secure_storage.dart';

import 'package:one_context/one_context.dart'; // import your storage class

class ThemeNotifier {
  static final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(
    ThemeMode.system,
  );
  static bool isDarkMode = false;
  static Future<void> init() async {
    bool isDark = await MySecureStorage.getIsDark();
    themeModeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  static Future<void> toggleTheme(bool isDark, BuildContext context) async {
    isDarkMode = isDark;

    await MySecureStorage.setIsDark(isDark);
    themeModeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
    OneNotification.hardReloadRoot(context);
    // context.toAndRemoveAll(LandingScreen());
    log("isDarkMode: $isDarkMode");
  }
}
