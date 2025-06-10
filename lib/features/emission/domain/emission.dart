class Emission {
  final String companyId;
  final DateTime month; // Format: 'YYYY-MM'

  // Scope 1 (Direct Emissions)
  final double vehicleFuelLitres; // e.g. diesel/petrol
  final double gasHeatingKWh; // e.g. natural gas usage

  // Scope 2 (Indirect from Energy)
  final double electricityKWh;

  // Scope 3 (Other Indirect)
  final double employeeCommuteKm;
  final int paperUsageReams;
  final double cloudUsageHours;

  Emission({
    required this.companyId,
    required this.month,
    required this.vehicleFuelLitres,
    required this.gasHeatingKWh,
    required this.electricityKWh,
    required this.employeeCommuteKm,
    required this.paperUsageReams,
    required this.cloudUsageHours,
  });

  factory Emission.fromMap(Map<String, dynamic> json) {
    return Emission(
      companyId: json['companyId'],
      month: json['month'],
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
      'month': month,
      'vehicleFuelLitres': vehicleFuelLitres,
      'gasHeatingKWh': gasHeatingKWh,
      'electricityKWh': electricityKWh,
      'employeeCommuteKm': employeeCommuteKm,
      'paperUsageReams': paperUsageReams,
      'cloudUsageHours': cloudUsageHours,
    };
  }
}
