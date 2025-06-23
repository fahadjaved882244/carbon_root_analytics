// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:carbon_root_analytics/features/auth/data/repository/i_auth_repository.dart';
import 'package:carbon_root_analytics/utils/core/result.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryRemote extends IAuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<Result<void>> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return Result.ok(null);
    } on FirebaseAuthException catch (e) {
      final error = _handleAuthException(e);
      return Result.error(Exception(error));
    }
  }

  @override
  Future<Result<void>> register({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Future.value(Result.ok(null));
    } on FirebaseAuthException catch (e) {
      final error = _handleAuthException(e);
      return Future.value(Result.error(Exception(error)));
    } catch (e) {
      return Future.value(
        Result.error(Exception('An unexpected error occurred')),
      );
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await _auth.signOut();
      return Result.ok(null);
    } catch (e) {
      return Result.error(Exception('An error occurred while logging out'));
    }
  }

  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      case 'invalid-email':
        return 'The email address is not valid.';
      default:
        return e.message ?? 'An error occurred';
    }
  }
}
