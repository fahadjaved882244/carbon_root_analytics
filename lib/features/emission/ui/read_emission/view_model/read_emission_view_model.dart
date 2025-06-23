import 'package:carbon_root_analytics/config/dependencies.dart';
import 'package:carbon_root_analytics/features/emission/domain/emission.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final readEmissionViewModelProvider = StreamProvider<List<Emission>>((ref) {
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
final mockEmissionsProvider = Provider<List<Emission>>((ref) {
  return [
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2024-01-01'),
      vehicleFuelLitres: 221.74,
      gasHeatingKWh: 1888.89,
      electricityKWh: 1050.00,
      employeeCommuteKm: 7000.00,
      paperUsageReams: 51,
      cloudUsageHours: 360.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2024-02-01'),
      vehicleFuelLitres: 203.48,
      gasHeatingKWh: 1733.33,
      electricityKWh: 950.00,
      employeeCommuteKm: 6708.33,
      paperUsageReams: 49,
      cloudUsageHours: 345.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2024-03-01'),
      vehicleFuelLitres: 239.13,
      gasHeatingKWh: 2044.44,
      electricityKWh: 1125.00,
      employeeCommuteKm: 7583.33,
      paperUsageReams: 56,
      cloudUsageHours: 390.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2024-04-01'),
      vehicleFuelLitres: 185.22,
      gasHeatingKWh: 1577.78,
      electricityKWh: 850.00,
      employeeCommuteKm: 6416.67,
      paperUsageReams: 47,
      cloudUsageHours: 330.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2024-05-01'),
      vehicleFuelLitres: 177.39,
      gasHeatingKWh: 1511.11,
      electricityKWh: 800.00,
      employeeCommuteKm: 6125.00,
      paperUsageReams: 45,
      cloudUsageHours: 315.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2024-06-01'),
      vehicleFuelLitres: 169.57,
      gasHeatingKWh: 1444.44,
      electricityKWh: 775.00,
      employeeCommuteKm: 5716.67,
      paperUsageReams: 42,
      cloudUsageHours: 294.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2024-07-01'),
      vehicleFuelLitres: 161.74,
      gasHeatingKWh: 1377.78,
      electricityKWh: 725.00,
      employeeCommuteKm: 5366.67,
      paperUsageReams: 39,
      cloudUsageHours: 276.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2024-08-01'),
      vehicleFuelLitres: 153.91,
      gasHeatingKWh: 1311.11,
      electricityKWh: 675.00,
      employeeCommuteKm: 5191.67,
      paperUsageReams: 38,
      cloudUsageHours: 267.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2024-09-01'),
      vehicleFuelLitres: 146.09,
      gasHeatingKWh: 1244.44,
      electricityKWh: 625.00,
      employeeCommuteKm: 4958.33,
      paperUsageReams: 36,
      cloudUsageHours: 255.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2024-10-01'),
      vehicleFuelLitres: 138.26,
      gasHeatingKWh: 1177.78,
      electricityKWh: 575.00,
      employeeCommuteKm: 4783.33,
      paperUsageReams: 35,
      cloudUsageHours: 246.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2024-11-01'),
      vehicleFuelLitres: 130.43,
      gasHeatingKWh: 1111.11,
      electricityKWh: 525.00,
      employeeCommuteKm: 4550.00,
      paperUsageReams: 33,
      cloudUsageHours: 234.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2024-12-01'),
      vehicleFuelLitres: 122.61,
      gasHeatingKWh: 1044.44,
      electricityKWh: 475.00,
      employeeCommuteKm: 4375.00,
      paperUsageReams: 32,
      cloudUsageHours: 225.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2023-01-01'),
      vehicleFuelLitres: 150.32,
      gasHeatingKWh: 1200.33,
      electricityKWh: 1260.00,
      employeeCommuteKm: 5000.00,
      paperUsageReams: 61,
      cloudUsageHours: 432.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2023-02-01'),
      vehicleFuelLitres: 244.18,
      gasHeatingKWh: 1000.00,
      electricityKWh: 1140.00,
      employeeCommuteKm: 5000.00,
      paperUsageReams: 59,
      cloudUsageHours: 414.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2023-03-01'),
      vehicleFuelLitres: 286.96,
      gasHeatingKWh: 1100.33,
      electricityKWh: 1350.00,
      employeeCommuteKm: 5300.00,
      paperUsageReams: 67,
      cloudUsageHours: 468.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2023-04-01'),
      vehicleFuelLitres: 222.26,
      gasHeatingKWh: 1893.33,
      electricityKWh: 1020.00,
      employeeCommuteKm: 5200.00,
      paperUsageReams: 56,
      cloudUsageHours: 396.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2023-05-01'),
      vehicleFuelLitres: 212.87,
      gasHeatingKWh: 1813.33,
      electricityKWh: 960.00,
      employeeCommuteKm: 5350.00,
      paperUsageReams: 54,
      cloudUsageHours: 378.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2023-06-01'),
      vehicleFuelLitres: 203.48,
      gasHeatingKWh: 1733.33,
      electricityKWh: 930.00,
      employeeCommuteKm: 6860.00,
      paperUsageReams: 50,
      cloudUsageHours: 352.80,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2023-07-01'),
      vehicleFuelLitres: 194.09,
      gasHeatingKWh: 1653.33,
      electricityKWh: 870.00,
      employeeCommuteKm: 6440.00,
      paperUsageReams: 47,
      cloudUsageHours: 331.20,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2023-08-01'),
      vehicleFuelLitres: 250.69,
      gasHeatingKWh: 1873.33,
      electricityKWh: 1100.00,
      employeeCommuteKm: 6230.00,
      paperUsageReams: 46,
      cloudUsageHours: 320.40,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2023-09-01'),
      vehicleFuelLitres: 260.31,
      gasHeatingKWh: 2200.33,
      electricityKWh: 1300.00,
      employeeCommuteKm: 5950.00,
      paperUsageReams: 43,
      cloudUsageHours: 306.00,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2023-10-01'),
      vehicleFuelLitres: 300.91,
      gasHeatingKWh: 2450.33,
      electricityKWh: 690.00,
      employeeCommuteKm: 5740.00,
      paperUsageReams: 42,
      cloudUsageHours: 295.20,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2023-11-01'),
      vehicleFuelLitres: 300.52,
      gasHeatingKWh: 2000.33,
      electricityKWh: 630.00,
      employeeCommuteKm: 5460.00,
      paperUsageReams: 40,
      cloudUsageHours: 280.80,
    ),
    Emission(
      companyId: 'COMP001',
      monthYear: DateTime.parse('2023-12-01'),
      vehicleFuelLitres: 250.13,
      gasHeatingKWh: 3000.33,
      electricityKWh: 570.00,
      employeeCommuteKm: 5250.00,
      paperUsageReams: 38,
      cloudUsageHours: 270.00,
    ),
  ];
});
