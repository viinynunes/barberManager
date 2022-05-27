import 'package:dartz/dartz.dart';
import 'package:string_validator/string_validator.dart';

import '../entities/client.dart';
import '../errors/registration_errors.dart';

class ValidateClientFields {

  static Either<RegistrationErrors, Client> validate(Client client) {
    if (!isEmail(client.email)) {
      return Left(ClientValidatorError('Invalid Email'));
    }

    if (client.name.isEmpty) {
      return Left(ClientValidatorError('Invalid Name'));
    }

    if (client.phoneNumber.isEmpty || client.phoneNumber.length != 11) {
      return Left(ClientValidatorError('Invalid Phone Number'));
    }

    return Right(client);
  }
}
