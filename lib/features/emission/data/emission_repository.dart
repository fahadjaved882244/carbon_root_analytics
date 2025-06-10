import 'package:carbon_root_analytics/features/emission/data/i_emission_repository.dart';
import 'package:carbon_root_analytics/features/emission/domain/emission.dart';
import 'package:carbon_root_analytics/utils/core/result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmissionRepository implements IEmissionRepository {
  final firestore = FirebaseFirestore.instance;

  @override
  Future<Result<List<Emission>>> fetchEmissionData(
    String userId,
    String companyId,
  ) async {
    try {
      final snapshot = await firestore
          .collection('users')
          .doc(userId)
          .collection('companies')
          .doc(companyId)
          .collection('emissions')
          .get();
      final emissions = snapshot.docs
          .map((doc) => Emission.fromMap(doc.data()))
          .toList();
      return Result.ok(emissions);
    } catch (e) {
      return Result.error(Exception('Failed to fetch emission data: $e'));
    }
  }

  @override
  Future<Result<Emission>> createEmissionRecord(
    String userId,
    Emission emission,
  ) async {
    try {
      await firestore
          .collection('users')
          .doc(userId)
          .collection('companies')
          .doc(emission.companyId)
          .collection('emissions')
          .add(emission.toMap());
      return Result.ok(emission);
    } catch (e) {
      return Result.error(
        Exception('Failed to create Carbon Emission record: $e'),
      );
    }
  }
}
