import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Center(
        child: Text(
          'Welcome to the Dashboard!',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
