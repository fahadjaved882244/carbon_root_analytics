import 'package:carbon_root_analytics/config/dependencies.dart';
import 'package:carbon_root_analytics/features/emission/domain/carbon_emission.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final readEmissionViewModelProvider = StreamProvider<List<CarbonEmission>>((
  ref,
) {
  final userId = ref.watch(authStateProvider).asData?.value?.uid;
  if (userId == null) {
    throw Exception('User ID is not available');
  }
  final company = ref.watch(readCompanyViewModelProvider).asData?.value;
  if (company == null) {
    throw Exception('Company data is not available');
  }
  final emissionRepository = ref.watch(emissionRepositoryProvider);

  final mockEmissions = ref.watch(mockEmissionsProvider);
  return emissionRepository
      .fetchEmissionData(userId, company.id)
      .map(
        (result) => result.fold(
          ok: (emissions) => emissions
            ..insertAll(0, mockEmissions)
            ..sort((a, b) => a.monthYear.compareTo(b.monthYear)),
          error: (error) {
            throw error;
          },
        ),
      );
});

// Mock Data Provider
final mockEmissionsProvider = Provider<List<CarbonEmission>>((ref) {
  return [
    CarbonEmission(
      companyId: "DOMINOS_MANCHESTER_001",
      monthYear: DateTime(2024, 1, 1),
      // Scope 1 - Higher gas usage in winter for heating
      gasConsumption: 3200.0, // kWh - winter heating
      dieselGenConsumption: 0.0, // L - no backup generator usage
      companyCarDistance: 180.0, // km - manager car usage
      deliveryVanDistance: 4500.0, // km - delivery operations (3 vans)
      forkliftFuelConsumption: 45.0, // L - warehouse operations
      refrigerantLeakage: 0.5, // kg - minor fridge maintenance
      // Scope 2 - High electricity for ovens and equipment
      electricityConsumption: 2800.0, // kWh - ovens, lights, equipment
      electricityForTdLosses: 280.0, // kWh - 10% of consumption
      // Scope 3 - Employee commuting and operations
      commuteCarDistance: 1250.0, // km - 10 employees drive (25km/day avg)
      commuteBusDistance: 750.0, // km - 15 employees use bus
      commuteTrainDistance: 0.0, // km - no train commuters
      foodWasteAmount: 0.8, // tonnes - pizza ingredients waste
      recycledWasteAmount: 1.2, // tonnes - packaging recycling
      paperReamsCount: 8.0, // reams - receipts, admin
    ),

    // February 2024
    CarbonEmission(
      companyId: "DOMINOS_MANCHESTER_001",
      monthYear: DateTime(2024, 2, 1),
      gasConsumption: 3000.0,
      dieselGenConsumption: 0.0,
      companyCarDistance: 165.0,
      deliveryVanDistance: 4200.0,
      forkliftFuelConsumption: 42.0,
      refrigerantLeakage: 0.3,
      electricityConsumption: 2650.0,
      electricityForTdLosses: 265.0,
      commuteCarDistance: 1150.0,
      commuteBusDistance: 700.0,
      commuteTrainDistance: 0.0,
      foodWasteAmount: 0.7,
      recycledWasteAmount: 1.1,
      paperReamsCount: 7.0,
    ),

    // March 2024
    CarbonEmission(
      companyId: "DOMINOS_MANCHESTER_001",
      monthYear: DateTime(2024, 3, 1),
      gasConsumption: 2600.0, // Spring - less heating
      dieselGenConsumption: 0.0,
      companyCarDistance: 190.0,
      deliveryVanDistance: 4800.0, // Busier month
      forkliftFuelConsumption: 48.0,
      refrigerantLeakage: 0.2,
      electricityConsumption: 2900.0,
      electricityForTdLosses: 290.0,
      commuteCarDistance: 1300.0,
      commuteBusDistance: 780.0,
      commuteTrainDistance: 0.0,
      foodWasteAmount: 0.9,
      recycledWasteAmount: 1.3,
      paperReamsCount: 9.0,
    ),

    // April 2024
    CarbonEmission(
      companyId: "DOMINOS_MANCHESTER_001",
      monthYear: DateTime(2024, 4, 1),
      gasConsumption: 2200.0,
      dieselGenConsumption: 0.0,
      companyCarDistance: 175.0,
      deliveryVanDistance: 4600.0,
      forkliftFuelConsumption: 46.0,
      refrigerantLeakage: 0.4,
      electricityConsumption: 2750.0,
      electricityForTdLosses: 275.0,
      commuteCarDistance: 1200.0,
      commuteBusDistance: 720.0,
      commuteTrainDistance: 0.0,
      foodWasteAmount: 0.8,
      recycledWasteAmount: 1.2,
      paperReamsCount: 8.0,
    ),

    // May 2024
    CarbonEmission(
      companyId: "DOMINOS_MANCHESTER_001",
      monthYear: DateTime(2024, 5, 1),
      gasConsumption: 1800.0, // Minimal heating needed
      dieselGenConsumption: 0.0,
      companyCarDistance: 185.0,
      deliveryVanDistance: 5000.0, // Good weather = more orders
      forkliftFuelConsumption: 50.0,
      refrigerantLeakage: 0.3,
      electricityConsumption: 3000.0,
      electricityForTdLosses: 300.0,
      commuteCarDistance: 1350.0,
      commuteBusDistance: 800.0,
      commuteTrainDistance: 0.0,
      foodWasteAmount: 1.0,
      recycledWasteAmount: 1.4,
      paperReamsCount: 10.0,
    ),

    // June 2024
    CarbonEmission(
      companyId: "DOMINOS_MANCHESTER_001",
      monthYear: DateTime(2024, 6, 1),
      gasConsumption: 1600.0,
      dieselGenConsumption: 0.0,
      companyCarDistance: 195.0,
      deliveryVanDistance: 5200.0, // Summer peak
      forkliftFuelConsumption: 52.0,
      refrigerantLeakage: 0.6, // AC usage increases refrigerant issues
      electricityConsumption: 3200.0, // AC + ovens
      electricityForTdLosses: 320.0,
      commuteCarDistance: 1400.0,
      commuteBusDistance: 850.0,
      commuteTrainDistance: 0.0,
      foodWasteAmount: 1.1,
      recycledWasteAmount: 1.5,
      paperReamsCount: 11.0,
    ),

    // July 2024
    CarbonEmission(
      companyId: "DOMINOS_MANCHESTER_001",
      monthYear: DateTime(2024, 7, 1),
      gasConsumption: 1400.0,
      dieselGenConsumption: 15.0, // Brief power outage - generator used
      companyCarDistance: 210.0, // Summer holidays - manager travels more
      deliveryVanDistance: 5500.0, // Peak summer orders
      forkliftFuelConsumption: 55.0,
      refrigerantLeakage: 0.8, // Peak AC usage
      electricityConsumption: 3400.0, // Highest AC usage
      electricityForTdLosses: 340.0,
      commuteCarDistance: 1450.0,
      commuteBusDistance: 900.0,
      commuteTrainDistance: 0.0,
      foodWasteAmount: 1.2,
      recycledWasteAmount: 1.6,
      paperReamsCount: 12.0,
    ),

    // August 2024
    CarbonEmission(
      companyId: "DOMINOS_MANCHESTER_001",
      monthYear: DateTime(2024, 8, 1),
      gasConsumption: 1500.0,
      dieselGenConsumption: 0.0,
      companyCarDistance: 200.0,
      deliveryVanDistance: 5300.0,
      forkliftFuelConsumption: 53.0,
      refrigerantLeakage: 0.7,
      electricityConsumption: 3300.0,
      electricityForTdLosses: 330.0,
      commuteCarDistance: 1400.0,
      commuteBusDistance: 850.0,
      commuteTrainDistance: 0.0,
      foodWasteAmount: 1.1,
      recycledWasteAmount: 1.5,
      paperReamsCount: 11.0,
    ),

    // September 2024
    CarbonEmission(
      companyId: "DOMINOS_MANCHESTER_001",
      monthYear: DateTime(2024, 9, 1),
      gasConsumption: 1800.0, // Autumn - heating starts
      dieselGenConsumption: 0.0,
      companyCarDistance: 180.0,
      deliveryVanDistance: 4900.0, // Back to school/work
      forkliftFuelConsumption: 49.0,
      refrigerantLeakage: 0.4,
      electricityConsumption: 2950.0, // Less AC needed
      electricityForTdLosses: 295.0,
      commuteCarDistance: 1300.0,
      commuteBusDistance: 780.0,
      commuteTrainDistance: 0.0,
      foodWasteAmount: 0.9,
      recycledWasteAmount: 1.3,
      paperReamsCount: 9.0,
    ),

    // October 2024
    CarbonEmission(
      companyId: "DOMINOS_MANCHESTER_001",
      monthYear: DateTime(2024, 10, 1),
      gasConsumption: 2200.0, // More heating
      dieselGenConsumption: 0.0,
      companyCarDistance: 170.0,
      deliveryVanDistance: 4700.0,
      forkliftFuelConsumption: 47.0,
      refrigerantLeakage: 0.3,
      electricityConsumption: 2800.0,
      electricityForTdLosses: 280.0,
      commuteCarDistance: 1250.0,
      commuteBusDistance: 750.0,
      commuteTrainDistance: 0.0,
      foodWasteAmount: 0.8,
      recycledWasteAmount: 1.2,
      paperReamsCount: 8.0,
    ),

    // November 2024
    CarbonEmission(
      companyId: "DOMINOS_MANCHESTER_001",
      monthYear: DateTime(2024, 11, 1),
      gasConsumption: 2800.0, // Winter heating increases
      dieselGenConsumption: 0.0,
      companyCarDistance: 165.0,
      deliveryVanDistance: 4400.0, // Weather affects delivery
      forkliftFuelConsumption: 44.0,
      refrigerantLeakage: 0.2,
      electricityConsumption: 2700.0,
      electricityForTdLosses: 270.0,
      commuteCarDistance: 1150.0,
      commuteBusDistance: 700.0,
      commuteTrainDistance: 0.0,
      foodWasteAmount: 0.7,
      recycledWasteAmount: 1.1,
      paperReamsCount: 7.0,
    ),

    // December 2024
    CarbonEmission(
      companyId: "DOMINOS_MANCHESTER_001",
      monthYear: DateTime(2024, 12, 1),
      gasConsumption: 3400.0, // Peak winter heating
      dieselGenConsumption: 0.0,
      companyCarDistance: 220.0, // Holiday season - more management travel
      deliveryVanDistance: 5800.0, // Christmas/New Year rush
      forkliftFuelConsumption: 58.0,
      refrigerantLeakage: 0.4,
      electricityConsumption: 3100.0, // Holiday decorations + equipment
      electricityForTdLosses: 310.0,
      commuteCarDistance: 1500.0, // Holiday shopping trips
      commuteBusDistance: 900.0,
      commuteTrainDistance: 0.0,
      foodWasteAmount: 1.3, // Holiday orders
      recycledWasteAmount: 1.7,
      paperReamsCount: 13.0, // Gift receipts, holiday promotions
    ),
  ];
});
