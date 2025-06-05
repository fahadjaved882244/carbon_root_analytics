import 'package:carbon_root_analytics/features/auth/repository/auth_repository_remote.dart';
import 'package:carbon_root_analytics/features/auth/repository/i_auth_repository.dart';
import 'package:carbon_root_analytics/features/auth/ui/login/view_model/login_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authStateProvider = StreamProvider<bool>((ref) {
  return FirebaseAuth.instance.authStateChanges().map((user) => user != null);
});

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  return AuthRepositoryRemote();
});
final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, LoginState>((ref) {
      final authRepository = ref.watch(authRepositoryProvider);
      return LoginViewModel(authRepository: authRepository);
    });
