abstract class RegistrationErrors implements Exception {}

class ClientRegistrationError implements RegistrationErrors {
  final String message;

  ClientRegistrationError(this.message);
}

class UserRegistrationError implements RegistrationErrors {
  final String message;

  UserRegistrationError(this.message);
}

class EstablishmentRegistrationError implements RegistrationErrors {
  final String message;

  EstablishmentRegistrationError(this.message);
}

class DepartmentRegistrationError implements RegistrationErrors {
  final String message;

  DepartmentRegistrationError(this.message);
}

class ItemRegistrationError implements RegistrationErrors {
  final String message;

  ItemRegistrationError(this.message);
}

