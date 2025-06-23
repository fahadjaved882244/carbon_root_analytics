import 'package:carbon_root_analytics/features/auth/data/repository/i_auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class LogoutState {
  final bool isLoading;
  final String? errorMessage;

  const LogoutState({this.isLoading = false, this.errorMessage});

  const LogoutState.initial() : isLoading = false, errorMessage = null;

  LogoutState copyWith({bool? isLoading, String? errorMessage}) {
    return LogoutState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class LogoutViewModel extends StateNotifier<LogoutState> {
  final IAuthRepository authRepository;
  LogoutViewModel({required this.authRepository})
    : super(LogoutState.initial());

  Future<void> logout() async {
    state = state.copyWith(isLoading: true);

    final result = await authRepository.logout();
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
