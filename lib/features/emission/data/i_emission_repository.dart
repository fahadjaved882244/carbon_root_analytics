import 'package:carbon_root_analytics/features/emission/domain/carbon_emission.dart';
import 'package:carbon_root_analytics/utils/core/result.dart';

abstract class IEmissionRepository {
  /// Fetches the emission data for a given [countryCode].
  ///
  /// Returns a [Future] that resolves to a list of emission data.
  Stream<Result<List<CarbonEmission>>> fetchEmissionData(
    String userId,
    String companyId,
  );

  /// creates a new emission record.
  /// /// Returns a [Future] that resolves to the created [Emission] object.
  Future<Result<CarbonEmission>> createEmissionRecord(
    String userId,
    CarbonEmission emission,
  );
}
