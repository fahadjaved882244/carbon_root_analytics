import 'package:carbon_root_analytics/firebase_options.dart';
import 'package:carbon_root_analytics/routing/router.dart';
import 'package:carbon_root_analytics/utils/data/local_db.dart';
import 'package:carbon_root_analytics/utils/theme/app_colors.dart';
import 'package:carbon_root_analytics/utils/theme/theme_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // Ensure that Flutter bindings are initialized before using any plugins
  WidgetsFlutterBinding.ensureInitialized();

  // Set the URL strategy to PathUrlStrategy for web applications
  // This allows the app to use clean URLs without the hash (#) in the URL
  usePathUrlStrategy();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const CRAApp(),
    ),
  );
}

class CRAApp extends ConsumerWidget {
  const CRAApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final brightness = ref.watch(themeControllerProvider) == ThemeMode.dark
        ? Brightness.dark
        : Brightness.light;

    return MaterialApp.router(
      title: 'CRA - Carbon Root Analytics',
      theme: ThemeData(
        // from seed
        colorSchemeSeed: AppColors.primary,

        fontFamily: 'Inter',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: brightness,
        useMaterial3: true,
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
