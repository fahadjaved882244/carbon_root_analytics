import 'dart:async';

import 'package:carbon_root_analytics/features/emission/data/i_emission_repository.dart';
import 'package:carbon_root_analytics/features/emission/domain/carbon_emission.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateEmissionViewModel
    extends StateNotifier<AsyncValue<CarbonEmission?>> {
  final String? _userId;
  final IEmissionRepository _emissionRepository;
  CreateEmissionViewModel(this._emissionRepository, this._userId)
    : super(const AsyncValue.data(null));

  Future<void> createEmissionRecord({
    required String companyId,
    required CarbonEmission emission,
  }) async {
    if (_userId == null) {
      state = AsyncValue.error(
        Exception('User ID is not available'),
        StackTrace.current,
      );
      return;
    }
    state = const AsyncValue.loading();

    final result = await _emissionRepository.createEmissionRecord(
      _userId,
      emission.copyWith(companyId: companyId),
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
