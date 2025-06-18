import 'dart:math' as math;

import 'package:flutter/cupertino.dart';

@immutable
class Emission {
  final String companyId;
  final DateTime monthYear; // Format: 'YYYY-MM'

  // Scope 1 (Direct Emissions)
  final double vehicleFuelLitres; // e.g. diesel/petrol
  final double gasHeatingKWh; // e.g. natural gas usage

  // Scope 2 (Indirect from Energy)
  final double electricityKWh;

  // Scope 3 (Other Indirect)
  final double employeeCommuteKm;
  final int paperUsageReams;
  final double cloudUsageHours;

  const Emission({
    required this.companyId,
    required this.monthYear,
    required this.vehicleFuelLitres,
    required this.gasHeatingKWh,
    required this.electricityKWh,
    required this.employeeCommuteKm,
    required this.paperUsageReams,
    required this.cloudUsageHours,
  });

  ///
  double get scope1 => vehicleFuelLitres * 2.31 + gasHeatingKWh * 0.184;
  double get scope2 => electricityKWh * 0.233;
  double get scope3 =>
      employeeCommuteKm * 0.18 + paperUsageReams * 2 + cloudUsageHours * 0.0025;
  double get total => scope1 + scope2 + scope3;

  double get target =>
      total * [0.85, 0.9, 1.0, 1.1, 1.2][math.Random().nextInt(5)];

  factory Emission.fromMap(Map<String, dynamic> json) {
    return Emission(
      companyId: json['companyId'],
      monthYear: json['month'],
      vehicleFuelLitres: json['vehicleFuelLitres'],
      gasHeatingKWh: json['gasHeatingKWh'],
      electricityKWh: json['electricityKWh'],
      employeeCommuteKm: json['employeeCommuteKm'],
      paperUsageReams: json['paperUsageReams'],
      cloudUsageHours: json['cloudUsageHours'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'companyId': companyId,
      'month': monthYear,
      'vehicleFuelLitres': vehicleFuelLitres,
      'gasHeatingKWh': gasHeatingKWh,
      'electricityKWh': electricityKWh,
      'employeeCommuteKm': employeeCommuteKm,
      'paperUsageReams': paperUsageReams,
      'cloudUsageHours': cloudUsageHours,
    };
  }
}
