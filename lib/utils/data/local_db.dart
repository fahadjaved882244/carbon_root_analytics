import 'dart:ui';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final localDbProvider = Provider<LocalDb>((ref) {
  final sharedPrefs = ref.watch(sharedPreferencesProvider);
  return LocalDb(sharedPrefs);
});

/// Remeber to override the [sharedPreferencesProvider] in the [runApp] method
///
/// void main() async {
///  WidgetsFlutterBinding.ensureInitialized();
///
/// final sharedPreferences = await SharedPreferences.getInstance();
///
/// runApp(ProviderScope(
///    overrides: [
///      sharedPreferencesProvider.overrideWithValue(sharedPreferences),
///    ],
///    child: const MyApp(),
///  ));
///
/// }

class LocalDb {
  final SharedPreferences _box;
  LocalDb(this._box);

  //////////// Dark Mode ////////////////
  static const _darkModeKey = 'isDarkMode';

  bool get darkMode => _box.getBool(_darkModeKey) ?? false;

  set darkMode(bool flag) => _box.setBool(_darkModeKey, flag);

  ///////////// Locale ///////////////////
  static const _languageKey = 'locale_language';
  static const _countryKey = 'locale_country';

  Locale get locale =>
      Locale(_box.getString(_languageKey) ?? 'en', _box.getString(_countryKey));

  set locale(Locale locale) {
    _box.setString(_languageKey, locale.languageCode);
    if (locale.countryCode != null) {
      _box.setString(_countryKey, locale.countryCode!);
    }
  }
}
