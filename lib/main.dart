import 'package:carbon_root_analytics/config/dependencies.dart';
import 'package:carbon_root_analytics/firebase_options.dart';
import 'package:carbon_root_analytics/routing/router.dart';
import 'package:carbon_root_analytics/utils/data/local_db.dart';
import 'package:carbon_root_analytics/utils/theme/theme_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    final isAuthenticated = ref.watch(authStateProvider);
    final brightness = ref.watch(themeControllerProvider) == ThemeMode.dark
        ? Brightness.dark
        : Brightness.light;

    return MaterialApp.router(
      title: 'CRA - Carbon Root Analytics',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Inter',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: brightness,
      ),

      routerConfig: router(isAuthenticated.valueOrNull ?? false),
      debugShowCheckedModeBanner: false,
    );
  }
}
