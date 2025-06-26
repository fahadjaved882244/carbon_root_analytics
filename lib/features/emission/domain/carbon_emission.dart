import 'package:flutter/material.dart';

@immutable
class CarbonEmission {
  final String companyId;
  final DateTime monthYear; // Format: 'YYYY-MM'

  // Scope 1 - Direct emissions
  final double gasConsumption; // kWh
  final double dieselGenConsumption; // L
  final double companyCarDistance; // km
  final double deliveryVanDistance; // km
  final double forkliftFuelConsumption; // L
  final double refrigerantLeakage; // kg

  // Scope 2 - Indirect energy emissions
  final double electricityConsumption; // kWh
  final double electricityForTdLosses; // kWh

  // Scope 3 - Other indirect emissions
  final double commuteCarDistance; // km
  final double commuteBusDistance; // km
  final double commuteTrainDistance; // km
  final double foodWasteAmount; // tonnes
  final double recycledWasteAmount; // tonnes
  final double paperReamsCount; // number of reams

  // Emission factors
  static const Map<String, Map<String, double>> emissionFactors = {
    'scope1': {
      'gas': 0.1829, // kg CO₂/kWh
      'dieselGen': 2.68, // kg CO₂/L
      'companyCars': 0.238, // kg CO₂/km
      'deliveryVans': 0.220, // kg CO₂/km
      'forklifts': 2.68, // kg CO₂/L
      'refrigerant': 1430, // GWP for R134a
    },
    'scope2': {
      'electricity': 0.207, // kg CO₂/kWh
      'tdLosses': 0.0183, // kg CO₂/kWh
    },
    'scope3': {
      'comCar': 0.171, // kg CO₂/km (average car)
      'comBus': 0.082, // kg CO₂/km (local bus)
      'comTrain': 0.041, // kg CO₂/km (national rail)
      'foodWaste': 3.3, // kg CO₂/tonne (food waste to landfill)
      'recycledWaste': 0.021, // kg CO₂/tonne (recycled materials)
      'paperReams': 3.29, // kg CO₂/ream (500 sheets A4 paper)
    },
  };

  const CarbonEmission({
    this.companyId = "0",
    required this.monthYear,
    this.gasConsumption = 0.0,
    this.dieselGenConsumption = 0.0,
    this.companyCarDistance = 0.0,
    this.deliveryVanDistance = 0.0,
    this.forkliftFuelConsumption = 0.0,
    this.refrigerantLeakage = 0.0,
    this.electricityConsumption = 0.0,
    this.electricityForTdLosses = 0.0,
    this.commuteCarDistance = 0.0,
    this.commuteBusDistance = 0.0,
    this.commuteTrainDistance = 0.0,
    this.foodWasteAmount = 0.0,
    this.recycledWasteAmount = 0.0,
    this.paperReamsCount = 0.0,
  });

  // Individual emission getters for Scope 1
  double get gasEmissions =>
      gasConsumption * emissionFactors['scope1']!['gas']!;
  double get dieselGenEmissions =>
      dieselGenConsumption * emissionFactors['scope1']!['dieselGen']!;
  double get companyCarEmissions =>
      companyCarDistance * emissionFactors['scope1']!['companyCars']!;
  double get deliveryVanEmissions =>
      deliveryVanDistance * emissionFactors['scope1']!['deliveryVans']!;
  double get forkliftEmissions =>
      forkliftFuelConsumption * emissionFactors['scope1']!['forklifts']!;
  double get refrigerantEmissions =>
      refrigerantLeakage * emissionFactors['scope1']!['refrigerant']!;

  // Individual emission getters for Scope 2
  double get electricityEmissions =>
      electricityConsumption * emissionFactors['scope2']!['electricity']!;
  double get tdLossesEmissions =>
      electricityForTdLosses * emissionFactors['scope2']!['tdLosses']!;

  // Individual emission getters for Scope 3
  double get commuteCarEmissions =>
      commuteCarDistance * emissionFactors['scope3']!['comCar']!;
  double get commuteBusEmissions =>
      commuteBusDistance * emissionFactors['scope3']!['comBus']!;
  double get commuteTrainEmissions =>
      commuteTrainDistance * emissionFactors['scope3']!['comTrain']!;
  double get foodWasteEmissions =>
      foodWasteAmount * emissionFactors['scope3']!['foodWaste']!;
  double get recycledWasteEmissions =>
      recycledWasteAmount * emissionFactors['scope3']!['recycledWaste']!;
  double get paperReamsEmissions =>
      paperReamsCount * emissionFactors['scope3']!['paperReams']!;

  // Function to get emission by controller key
  double getEmissionByKey(String key) {
    switch (key) {
      // Scope 1
      case 'gasKwh':
        return gasEmissions;
      case 'dieselGen':
        return dieselGenEmissions;
      case 'companyCars':
        return companyCarEmissions;
      case 'deliveryVans':
        return deliveryVanEmissions;
      case 'forklifts':
        return forkliftEmissions;
      case 'refrigerant':
        return refrigerantEmissions;

      // Scope 2
      case 'electricity':
        return electricityEmissions;
      case 'tdLosses':
        return tdLossesEmissions;

      // Scope 3
      case 'comCar':
        return commuteCarEmissions;
      case 'comBus':
        return commuteBusEmissions;
      case 'comTrain':
        return commuteTrainEmissions;
      case 'foodWaste':
        return foodWasteEmissions;
      case 'recycledWaste':
        return recycledWasteEmissions;
      case 'paperReams':
        return paperReamsEmissions;

      default:
        throw ArgumentError('Unknown emission key: $key');
    }
  }

  // Total emissions by scope
  double get scope1Emissions =>
      gasEmissions +
      dieselGenEmissions +
      companyCarEmissions +
      deliveryVanEmissions +
      forkliftEmissions +
      refrigerantEmissions;

  double get scope2Emissions => electricityEmissions + tdLossesEmissions;

  double get scope3Emissions =>
      commuteCarEmissions +
      commuteBusEmissions +
      commuteTrainEmissions +
      foodWasteEmissions +
      recycledWasteEmissions +
      paperReamsEmissions;

  // Total emissions across all scopes
  double get totalEmissions =>
      scope1Emissions + scope2Emissions + scope3Emissions;

  // Get Projected Emissions
  double get targetEmissions => scope1Emissions * 1.05; // 5% increase

  // Breakdown by category (useful for reporting)
  Map<String, double> get scope1Breakdown => {
    'gas': gasEmissions,
    'dieselGen': dieselGenEmissions,
    'companyCars': companyCarEmissions,
    'deliveryVans': deliveryVanEmissions,
    'forklifts': forkliftEmissions,
    'refrigerant': refrigerantEmissions,
  };

  Map<String, double> get scope2Breakdown => {
    'electricity': electricityEmissions,
    'tdLosses': tdLossesEmissions,
  };

  Map<String, double> get scope3Breakdown => {
    'comCar': commuteCarEmissions,
    'comBus': commuteBusEmissions,
    'comTrain': commuteTrainEmissions,
    'foodWaste': foodWasteEmissions,
    'recycledWaste': recycledWasteEmissions,
    'paperReams': paperReamsEmissions,
  };

  Map<String, double> get allScopesBreakdown => {
    'scope1': scope1Emissions,
    'scope2': scope2Emissions,
    'scope3': scope3Emissions,
    'total': totalEmissions,
  };

  // CopyWith method
  CarbonEmission copyWith({
    String? companyId,
    DateTime? monthYear,
    double? gasConsumption,
    double? dieselGenConsumption,
    double? companyCarDistance,
    double? deliveryVanDistance,
    double? forkliftFuelConsumption,
    double? refrigerantLeakage,
    double? electricityConsumption,
    double? electricityForTdLosses,
    double? commuteCarDistance,
    double? commuteBusDistance,
    double? commuteTrainDistance,
    double? foodWasteAmount,
    double? recycledWasteAmount,
    double? paperReamsCount,
  }) {
    return CarbonEmission(
      companyId: companyId ?? this.companyId,
      monthYear: monthYear ?? this.monthYear,
      gasConsumption: gasConsumption ?? this.gasConsumption,
      dieselGenConsumption: dieselGenConsumption ?? this.dieselGenConsumption,
      companyCarDistance: companyCarDistance ?? this.companyCarDistance,
      deliveryVanDistance: deliveryVanDistance ?? this.deliveryVanDistance,
      forkliftFuelConsumption:
          forkliftFuelConsumption ?? this.forkliftFuelConsumption,
      refrigerantLeakage: refrigerantLeakage ?? this.refrigerantLeakage,
      electricityConsumption:
          electricityConsumption ?? this.electricityConsumption,
      electricityForTdLosses:
          electricityForTdLosses ?? this.electricityForTdLosses,
      commuteCarDistance: commuteCarDistance ?? this.commuteCarDistance,
      commuteBusDistance: commuteBusDistance ?? this.commuteBusDistance,
      commuteTrainDistance: commuteTrainDistance ?? this.commuteTrainDistance,
      foodWasteAmount: foodWasteAmount ?? this.foodWasteAmount,
      recycledWasteAmount: recycledWasteAmount ?? this.recycledWasteAmount,
      paperReamsCount: paperReamsCount ?? this.paperReamsCount,
    );
  }

  // Equality and hashCode
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CarbonEmission &&
        other.companyId == companyId &&
        other.monthYear == monthYear &&
        other.gasConsumption == gasConsumption &&
        other.dieselGenConsumption == dieselGenConsumption &&
        other.companyCarDistance == companyCarDistance &&
        other.deliveryVanDistance == deliveryVanDistance &&
        other.forkliftFuelConsumption == forkliftFuelConsumption &&
        other.refrigerantLeakage == refrigerantLeakage &&
        other.electricityConsumption == electricityConsumption &&
        other.electricityForTdLosses == electricityForTdLosses &&
        other.commuteCarDistance == commuteCarDistance &&
        other.commuteBusDistance == commuteBusDistance &&
        other.commuteTrainDistance == commuteTrainDistance &&
        other.foodWasteAmount == foodWasteAmount &&
        other.recycledWasteAmount == recycledWasteAmount &&
        other.paperReamsCount == paperReamsCount;
  }

  @override
  int get hashCode {
    return Object.hash(
      gasConsumption,
      dieselGenConsumption,
      companyCarDistance,
      deliveryVanDistance,
      forkliftFuelConsumption,
      refrigerantLeakage,
      electricityConsumption,
      electricityForTdLosses,
      commuteCarDistance,
      commuteBusDistance,
      commuteTrainDistance,
      foodWasteAmount,
      recycledWasteAmount,
      paperReamsCount,
    );
  }

  @override
  String toString() {
    return 'CarbonEmissions(scope1: ${scope1Emissions.toStringAsFixed(2)} kg CO₂, '
        'scope2: ${scope2Emissions.toStringAsFixed(2)} kg CO₂, '
        'scope3: ${scope3Emissions.toStringAsFixed(2)} kg CO₂, '
        'total: ${totalEmissions.toStringAsFixed(2)} kg CO₂)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'companyId': companyId,
      'month': monthYear,
      'gasConsumption': gasConsumption,
      'dieselGenConsumption': dieselGenConsumption,
      'companyCarDistance': companyCarDistance,
      'deliveryVanDistance': deliveryVanDistance,
      'forkliftFuelConsumption': forkliftFuelConsumption,
      'refrigerantLeakage': refrigerantLeakage,
      'electricityConsumption': electricityConsumption,
      'electricityForTdLosses': electricityForTdLosses,
      'commuteCarDistance': commuteCarDistance,
      'commuteBusDistance': commuteBusDistance,
      'commuteTrainDistance': commuteTrainDistance,
      'foodWasteAmount': foodWasteAmount,
      'recycledWasteAmount': recycledWasteAmount,
      'paperReamsCount': paperReamsCount,
    };
  }

  factory CarbonEmission.fromMap(Map<String, dynamic> map) {
    return CarbonEmission(
      companyId: map['companyId'],
      // parse datetime from timestamp firestore
      monthYear: map['month'].toDate(),
      gasConsumption: map['gasConsumption'] as double,
      dieselGenConsumption: map['dieselGenConsumption'] as double,
      companyCarDistance: map['companyCarDistance'] as double,
      deliveryVanDistance: map['deliveryVanDistance'] as double,
      forkliftFuelConsumption: map['forkliftFuelConsumption'] as double,
      refrigerantLeakage: map['refrigerantLeakage'] as double,
      electricityConsumption: map['electricityConsumption'] as double,
      electricityForTdLosses: map['electricityForTdLosses'] as double,
      commuteCarDistance: map['commuteCarDistance'] as double,
      commuteBusDistance: map['commuteBusDistance'] as double,
      commuteTrainDistance: map['commuteTrainDistance'] as double,
      foodWasteAmount: map['foodWasteAmount'] as double,
      recycledWasteAmount: map['recycledWasteAmount'] as double,
      paperReamsCount: map['paperReamsCount'] as double,
    );
  }
}
