import 'dart:async';

import 'package:carbon_root_analytics/features/emission/data/i_emission_repository.dart';
import 'package:carbon_root_analytics/features/emission/domain/emission.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateEmissionViewModel extends StateNotifier<AsyncValue<Emission?>> {
  final String? _userId;
  final IEmissionRepository _emissionRepository;
  CreateEmissionViewModel(this._emissionRepository, this._userId)
    : super(const AsyncValue.data(null));

  Future<void> createEmissionRecord({
    required String companyId,

    required int month,
    required int year,

    required double vehicleFuelLitres,
    required double gasHeatingKWh,

    required double electricityKWh,

    required double employeeCommuteKm,
    required int paperUsageReams,
    required double cloudUsageHours,
  }) async {
    if (_userId == null) {
      state = AsyncValue.error(
        Exception('User ID is not available'),
        StackTrace.current,
      );
      return;
    }
    state = const AsyncValue.loading();

    final emission = Emission(
      companyId: companyId,
      month: DateTime(year, month),
      vehicleFuelLitres: vehicleFuelLitres,
      gasHeatingKWh: gasHeatingKWh,
      electricityKWh: electricityKWh,
      employeeCommuteKm: employeeCommuteKm,
      paperUsageReams: paperUsageReams,
      cloudUsageHours: cloudUsageHours,
    );

    final result = await _emissionRepository.createEmissionRecord(
      _userId,
      emission,
    );
    result.fold(
      ok: (createdEmission) {
        state = AsyncValue.data(createdEmission);
      },
      error: (error) {
        state = AsyncValue.error(
          Exception('Failed to create emission record: $error'),
          StackTrace.current,
        );
      },
    );
  }
}
