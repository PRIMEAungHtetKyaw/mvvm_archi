import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Enum to represent the app's theme mode.
enum AppThemeMode { light, dark, system }

/// StateNotifier to manage theme mode.
class ThemeController extends StateNotifier<ThemeMode> {
  ThemeController() : super(ThemeMode.system);

  /// Toggle between light and dark themes
  void setThemeMode(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        state = ThemeMode.light;
        break;
      case AppThemeMode.dark:
        state = ThemeMode.dark;
        break;
      case AppThemeMode.system:
        state = ThemeMode.system;
        break;
    }
  }
}

/// Riverpod provider for theme controller.
final themeControllerProvider = StateNotifierProvider<ThemeController, ThemeMode>(
  (ref) => ThemeController(),
);
