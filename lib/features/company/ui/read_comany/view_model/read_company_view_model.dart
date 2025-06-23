import 'dart:async';

import 'package:carbon_root_analytics/config/dependencies.dart';
import 'package:carbon_root_analytics/features/company/data/i_company_repository.dart';
import 'package:carbon_root_analytics/features/company/domain/company_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ReadCompanyViewModel extends AsyncNotifier<Company?> {
  @override
  FutureOr<Company?> build() async {
    final repo = ref.watch(companyRepositoryProvider);
    final userId = ref.watch(authStateProvider).value?.uid;
    if (userId != null) {
      return getCompany(repo, userId);
    } else {
      throw Exception('User ID is null');
    }
  }

  Future<Company?> getCompany(ICompanyRepository repo, String userId) async {
    final result = repo.getCompany(userId);
    return result.then((value) {
      return value.fold(
        ok: (company) => company,
        error: (error) {
          throw error;
        },
      );
    });
  }
}
