import 'package:carbon_root_analytics/features/auth/data/repository/i_auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class RegisterState {
  final bool isLoading;
  final String? errorMessage;

  const RegisterState({this.isLoading = false, this.errorMessage});

  const RegisterState.initial() : isLoading = false, errorMessage = null;

  RegisterState copyWith({bool? isLoading, String? errorMessage}) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class RegisterViewModel extends StateNotifier<RegisterState> {
  final IAuthRepository authRepository;
  RegisterViewModel({required this.authRepository})
    : super(RegisterState.initial());

  Future<void> register(String email, String password) async {
    state = state.copyWith(isLoading: true);

    final result = await authRepository.register(
      email: email,
      password: password,
    );
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
