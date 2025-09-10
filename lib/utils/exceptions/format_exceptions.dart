class SFormatExceptions implements Exception {

  final String message;

  const SFormatExceptions([this.message = 'An unexpected format error occurred. Please check your input.']);

  // Create a format exception from a specific error message.
  factory SFormatExceptions.fromMessage(String message) {
    return SFormatExceptions(message);
  }

  /// Get the corresponding error message.
  String get formattedMessage => message;

  /// Create a format exception from a specific error code.
  factory SFormatExceptions.fromCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return const SFormatExceptions('The email address format is invalid. Please enter a valid email.');
      case 'invalid-phone-number-format':
        return const SFormatExceptions('The provided phone number format is invalid. Please enter a valid number.');
      case 'invalid-date-format':
        return const SFormatExceptions('The date format is invalid. Please enter a valid date.');
      case 'invalid-url-format':
        return const SFormatExceptions('The URL format is invalid. Please enter a valid URL.');
      case 'invalid-credit-card-format':
        return const SFormatExceptions('The credit card format is invalid. Please enter a valid credit card number.');
      case 'invalid-numeric-format':
        return const SFormatExceptions('The input should be a valid numeric format.');
    // Add more cases as needed...
      default:
        return const SFormatExceptions();
    }
  }
}