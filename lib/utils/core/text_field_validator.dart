class TextFieldValidator {
  /// Validates if the input text is not empty.
  static String? validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  /// Validates if the input text matches a specific pattern.
  static String? validatePattern(String? value, RegExp pattern) {
    if (value == null || !pattern.hasMatch(value)) {
      return 'Invalid format';
    }
    return null;
  }

  /// Validates if the input text is a valid email address.
  static String? validateEmail(String? value) {
    final emailPattern = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return validatePattern(value, emailPattern);
  }

  /// Validates a name field to ensure it contains only letters and spaces.
  static String? validateName(String? value) {
    final value0 = value?.trim() ?? '';
    if (value0.isEmpty) {
      return 'Field cannot be empty';
    } else if (value0.length < 3) {
      return 'Field must be at least 3 characters';
    }
    return null;
  }

  /// Validates a number field to ensure it contains only digits.
  static String? validateNumber(String? value) {
    final value0 = value?.trim() ?? '';
    if (value0.isEmpty) {
      return 'Field cannot be empty';
    } else if (int.tryParse(value0) == null) {
      return 'Field must contain only digits';
    }
    return null;
  }
}
