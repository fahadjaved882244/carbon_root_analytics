import 'dart:async';

import 'package:carbon_root_analytics/config/dependencies.dart';
import 'package:carbon_root_analytics/features/company/data/i_company_repository.dart';
import 'package:carbon_root_analytics/features/company/domain/company_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

class CreateCompanyViewModel extends AsyncNotifier<Company?> {
  late final ICompanyRepository _companyRepository;

  CreateCompanyViewModel();

  @override
  FutureOr<Company?> build() {
    _companyRepository = ref.watch(companyRepositoryProvider);
    return null;
  }

  Future<void> createCompany({
    required String userId,
    required String name,
    required String industry,
    required int numberOfEmployees,
    required String location,
  }) async {
    state = const AsyncValue.loading();

    final company = Company(
      userId: userId,
      id: Uuid().v4(),
      name: name,
      industry: industry,
      numberOfEmployees: numberOfEmployees,
      location: location,
      lastUpdated: DateTime.now(),
    );

    final result = await _companyRepository.createCompany(company);

    result.fold(
      ok: (data) {
        state = AsyncValue.data(data);
      },
      error: (error) {
        state = AsyncValue.error(error, StackTrace.current);
      },
    );
  }
}
