import 'package:flutter/material.dart';

class Destination {
  const Destination(this.icon, this.label);
  final IconData icon;
  final String label;
}

const List<Destination> myDestinations = <Destination>[
  Destination(Icons.account_circle_outlined, 'Home'),
  Destination(Icons.code, 'Projects'),
  Destination(Icons.timeline, 'Experience'),
  Destination(Icons.email_outlined, 'Contact'),
];
