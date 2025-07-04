import 'package:flutter/material.dart';

class Destination {
  const Destination(this.icon, this.label);
  final IconData icon;
  final String label;
}

const List<Destination> myDestinations = <Destination>[
  Destination(Icons.dashboard_outlined, 'Dashboard'),
  Destination(Icons.timeline_outlined, 'Logs'),
  Destination(Icons.trending_down, 'Reduction'),
  Destination(Icons.campaign_outlined, 'Offset'),
  Destination(Icons.bar_chart_outlined, 'Reports'),
  Destination(Icons.diamond_outlined, 'Premium'),
];
