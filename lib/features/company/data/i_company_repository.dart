import 'package:carbon_root_analytics/features/company/domain/company_model.dart';
import 'package:carbon_root_analytics/utils/core/result.dart';

abstract class ICompanyRepository {
  Future<Result<Company?>> getCompany(String id);
  Future<Result<Company>> createCompany(Company company);
  Future<Result<void>> updateCompany(Company company);
}
