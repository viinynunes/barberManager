import 'package:dartz/dartz.dart';
import 'package:string_validator/string_validator.dart';

import '../../entities/client.dart';
import '../../errors/registration_errors.dart';

class ValidateClientFields {
  Either<ClientRegistrationError, Client> createOrUpdateValidator(
      Client client) {
    if (!isEmail(client.email)) {
      return Left(ClientRegistrationError('Invalid Email'));
    }

    if (client.name.isEmpty) {
      return Left(ClientRegistrationError('Invalid Name'));
    }

    if (client.phoneNumber.isEmpty || client.phoneNumber.length != 11) {
      return Left(ClientRegistrationError('Invalid Phone Number'));
    }

    return Right(client);
  }

  Either<ClientRegistrationError, bool> disableValidator(Client client) {
    if (!client.enabled) {
      return Left(ClientRegistrationError('Client already disabled'));
    }

    return const Right(true);
  }

  Either<ClientRegistrationError, Client> findByIdValidator(String id) {
    if (id.isEmpty) {
      return Left(ClientRegistrationError('Client ID is empty'));
    }

    return Right(Client('', '', '', '', false));
  }
}
