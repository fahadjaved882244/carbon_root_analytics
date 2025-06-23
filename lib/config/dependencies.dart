import 'package:carbon_root_analytics/features/auth/data/repository/auth_repository_remote.dart';
import 'package:carbon_root_analytics/features/auth/data/repository/i_auth_repository.dart';
import 'package:carbon_root_analytics/features/auth/ui/login/view_model/login_view_model.dart';
import 'package:carbon_root_analytics/features/auth/ui/logout/view_model/logout_view_model.dart';
import 'package:carbon_root_analytics/features/auth/ui/register/view_model/register_view_model.dart';
import 'package:carbon_root_analytics/features/company/data/company_repository_remote.dart';
import 'package:carbon_root_analytics/features/company/data/i_company_repository.dart';
import 'package:carbon_root_analytics/features/company/domain/company_model.dart';
import 'package:carbon_root_analytics/features/company/ui/create_company/view_model/create_company_view_model.dart';
import 'package:carbon_root_analytics/features/company/ui/read_comany/view_model/read_company_view_model.dart';
import 'package:carbon_root_analytics/features/emission/data/emission_repository.dart';
import 'package:carbon_root_analytics/features/emission/data/i_emission_repository.dart';
import 'package:carbon_root_analytics/features/emission/domain/emission.dart';
import 'package:carbon_root_analytics/features/emission/ui/create_emission/view_model/create_emission_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  return AuthRepositoryRemote();
});
final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, LoginState>((ref) {
      final authRepository = ref.watch(authRepositoryProvider);
      return LoginViewModel(authRepository: authRepository);
    });

final registerViewModelProvider =
    StateNotifierProvider<RegisterViewModel, RegisterState>((ref) {
      final authRepository = ref.watch(authRepositoryProvider);
      return RegisterViewModel(authRepository: authRepository);
    });

final logoutViewModelProvider =
    StateNotifierProvider<LogoutViewModel, LogoutState>((ref) {
      final authRepository = ref.watch(authRepositoryProvider);
      return LogoutViewModel(authRepository: authRepository);
    });

final companyRepositoryProvider = Provider<ICompanyRepository>((ref) {
  return CompanyRepositoryRemote();
});

final createCompanyViewModelProvider =
    AsyncNotifierProvider<CreateCompanyViewModel, Company?>(() {
      return CreateCompanyViewModel();
    });

final readCompanyViewModelProvider =
    AsyncNotifierProvider<ReadCompanyViewModel, Company?>(() {
      return ReadCompanyViewModel();
    });

final emissionRepositoryProvider = Provider<IEmissionRepository>((ref) {
  return EmissionRepository();
});

final createEmissionViewModelProvider =
    StateNotifierProvider<CreateEmissionViewModel, AsyncValue<Emission?>>((
      ref,
    ) {
      final emissionRepository = ref.watch(emissionRepositoryProvider);
      final userId = ref.watch(authStateProvider).value?.uid;
      return CreateEmissionViewModel(emissionRepository, userId);
    });
