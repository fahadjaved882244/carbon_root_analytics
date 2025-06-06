import 'package:carbon_root_analytics/features/auth/repository/i_auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class LoginState {
  final bool isLoading;
  final String? errorMessage;

  const LoginState({this.isLoading = false, this.errorMessage});

  const LoginState.initial() : isLoading = false, errorMessage = null;

  LoginState copyWith({bool? isLoading, String? errorMessage}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class LoginViewModel extends StateNotifier<LoginState> {
  final IAuthRepository authRepository;
  LoginViewModel({required this.authRepository}) : super(LoginState.initial());

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true);

    final result = await authRepository.login(email: email, password: password);
    result.fold(
      ok: (_) {
        state = state.copyWith(isLoading: false, errorMessage: null);
      },
      error: (error) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: error.toString(),
        );
      },
    );
  }
}
