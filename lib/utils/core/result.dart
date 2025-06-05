// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Utility class to wrap result data
///
/// Evaluate the result using a switch statement:
/// ```dart
/// switch (result) {
///   case Ok(): {
///     print(result.value);
///   }
///   case Error(): {
///     print(result.error);
///   }
/// }
/// ```
sealed class Result<T> {
  const Result();

  /// Creates a successful [Result], completed with the specified [value].
  const factory Result.ok(T value) = Ok._;

  /// Creates an error [Result], completed with the specified [error].
  const factory Result.error(Exception error) = Error._;

  /// Returns true if the result is an [Ok] instance.
  bool get isOk => this is Ok<T>;

  /// Returns true if the result is an [Error] instance.
  bool get isError => this is Error<T>;

  /// Applies the provided functions to the result, returning the value from the
  /// function corresponding to the result type.
  R fold<R>({
    required R Function(T value) ok,
    required R Function(Exception error) error,
  }) {
    if (this is Ok<T>) {
      return ok((this as Ok<T>).value);
    } else if (this is Error<T>) {
      return error((this as Error<T>).error);
    } else {
      throw StateError('Unknown result type');
    }
  }
}

/// Subclass of Result for values
final class Ok<T> extends Result<T> {
  const Ok._(this.value);

  /// Returned value in result
  final T value;

  @override
  String toString() => 'Result<$T>.ok($value)';
}

/// Subclass of Result for errors
final class Error<T> extends Result<T> {
  const Error._(this.error);

  /// Returned error in result
  final Exception error;

  @override
  String toString() => 'Result<$T>.error($error)';
}
