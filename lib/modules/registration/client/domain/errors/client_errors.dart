abstract class ClientErrors implements Exception {}

class ClientValidatorError implements ClientErrors {
  final String message;

  ClientValidatorError(this.message);
}
