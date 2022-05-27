abstract class RegistrationErrors implements Exception {}

class ClientValidatorError implements RegistrationErrors {
  final String message;

  ClientValidatorError(this.message);
}

class UserRegistrationError implements RegistrationErrors {
  final String message;

  UserRegistrationError(this.message);
}
