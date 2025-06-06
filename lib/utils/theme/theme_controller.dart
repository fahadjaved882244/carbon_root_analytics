import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:carbon_root_analytics/utils/data/local_db.dart';

final themeControllerProvider =
    StateNotifierProvider<ThemeController, ThemeMode>((ref) {
      final storage = ref.watch(localDbProvider);
      return ThemeController(storage);
    });

class ThemeController extends StateNotifier<ThemeMode> {
  final LocalDb _localDb;
  ThemeController(this._localDb) : super(ThemeMode.light);

  void toggleThemeMode() {
    if (state == ThemeMode.light) {
      state = ThemeMode.dark;
      _localDb.darkMode = true;
    } else {
      state = ThemeMode.light;
      _localDb.darkMode = false;
    }
  }
}
