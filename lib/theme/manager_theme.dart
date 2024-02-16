import 'dart:async';

import 'package:flutter/material.dart';

class ThemeModeManager {

  static ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  static bool get isDark => _themeMode == ThemeMode.dark;

  static final _streamController = StreamController<ThemeMode>.broadcast();

  Stream<ThemeMode> get onThemeChange => _streamController.stream;

  set themeMode(ThemeMode mode) {
    _themeMode = mode;
    _streamController.sink.add(mode);
  }
}
