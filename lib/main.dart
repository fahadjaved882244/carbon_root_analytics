import 'package:carbon_root_analytics/features/home/view/home_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CRAApp());
}

class CRAApp extends StatelessWidget {
  const CRAApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRA - Carbon Root Analytics',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Inter',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
