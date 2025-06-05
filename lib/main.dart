import 'package:carbon_root_analytics/routing/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyA4xT7T6fmM4HnQEz3qbpJ3SbLBkqGTxog",
      authDomain: "carbon-root-analysis.firebaseapp.com",
      projectId: "carbon-root-analysis",
      storageBucket: "carbon-root-analysis.firebasestorage.app",
      messagingSenderId: "834307778618",
      appId: "1:834307778618:web:6eca8c00808f3025ae2d03",
      measurementId: "G-PCBPSQHH8W",
    ),
  );
  runApp(const CRAApp());
}

class CRAApp extends StatelessWidget {
  const CRAApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'CRA - Carbon Root Analytics',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Inter',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
