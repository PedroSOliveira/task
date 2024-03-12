import 'dart:async';

import 'package:flutter/material.dart';

class ThemeModeManager {
  static ThemeModeManager? _instance;

  ThemeModeManager._();

  static ThemeModeManager get instance => _instance ??= ThemeModeManager._();

  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get isDark => _themeMode == ThemeMode.dark;

  final _streamController = StreamController<ThemeMode>.broadcast();

  Stream<ThemeMode> get onThemeChange => _streamController.stream;

  set themeMode(ThemeMode mode) {
    _themeMode = mode;
    _streamController.sink.add(mode);
  }
}
