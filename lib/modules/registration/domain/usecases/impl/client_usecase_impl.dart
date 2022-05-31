import 'package:dartz/dartz.dart';

import '../../entities/client.dart';
import '../../errors/registration_errors.dart';
import '../../repositories/client_repository.dart';
import '../../validations/validate_client_fields.dart';
import '../client_usecase.dart';

class ClientUsecaseImpl implements ClientUsecase {
  final ClientRepository _repository;

  ClientUsecaseImpl(this._repository);

  @override
  Future<Either<RegistrationErrors, Client>> createOrUpdate(
      Client client) async {
    final validator = ValidateClientFields.createOrUpdateValidator(client);

    if (validator.isLeft()) {
      return validator;
    }

    return await _repository.createOrUpdate(client);
  }

  @override
  Future<Either<RegistrationErrors, bool>> delete(Client client) async {
    final validator = ValidateClientFields.disableValidator(client);

    if (validator.isLeft()) {
      return validator;
    }

    return await _repository.delete(client);
  }
}
