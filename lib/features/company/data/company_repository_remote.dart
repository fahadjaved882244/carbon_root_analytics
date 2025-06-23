import 'package:carbon_root_analytics/features/company/data/i_company_repository.dart';
import 'package:carbon_root_analytics/features/company/domain/company_model.dart';
import 'package:carbon_root_analytics/utils/core/result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyRepositoryRemote implements ICompanyRepository {
  final firestore = FirebaseFirestore.instance;

  @override
  Future<Result<Company>> createCompany(Company company) async {
    try {
      await firestore
          .collection('users')
          .doc(company.userId)
          .collection('companies')
          .doc(company.id)
          .set(company.toMap());
      return Result.ok(company);
    } catch (e) {
      return Result.error(Exception('Failed to create company'));
    }
  }

  @override
  Future<Result<Company?>> getCompany(String userId) async {
    try {
      final snapshot = await firestore
          .collection('users')
          .doc(userId)
          .collection('companies')
          .get();

      if (snapshot.docs.isEmpty) {
        return Result.ok(null);
      }
      final data = snapshot.docs.first.data();

      final result = Company.fromMap(data);
      return result.fold(
        ok: (comapny) => Result.ok(comapny),
        error: (error) => Result.error(error),
      );
    } catch (e) {
      return Result.error(Exception('Failed to fetch company'));
    }
  }

  @override
  Future<Result<void>> updateCompany(Company company) {
    // TODO: implement updateCompany
    throw UnimplementedError();
  }
}
