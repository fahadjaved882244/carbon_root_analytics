import '../../../../utils/core/result.dart';

abstract class IAuthRepository {
  /// Perform login
  Future<Result<void>> login({required String email, required String password});

  /// Perform registration of new user with email and password
  Future<Result<void>> register({
    required String email,
    required String password,
  });

  /// Perform logout
  Future<Result<void>> logout();
}
