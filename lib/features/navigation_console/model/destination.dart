import 'package:flutter/material.dart';

class Destination {
  const Destination(this.icon, this.label);
  final IconData icon;
  final String label;
}

const List<Destination> myDestinations = <Destination>[
  Destination(Icons.dashboard_outlined, 'Dashboard'),
  Destination(Icons.settings_outlined, 'Settings'),
  Destination(Icons.timeline_outlined, 'Logs'),
];
