import 'package:dartz/dartz.dart';

import '../../entities/client.dart';
import '../../errors/registration_errors.dart';
import '../../repositories/client_repository.dart';
import '../client_usecase.dart';
import '../validations/validate_client_fields.dart';

class ClientUsecaseImpl implements ClientUsecase {
  final ClientRepository _repository;
  final _validator = ValidateClientFields();

  ClientUsecaseImpl(this._repository);

  @override
  Future<Either<ClientRegistrationError, Client>> createOrUpdate(
      Client client) async {
    final result = _validator.createOrUpdateValidator(client);

    if (result.isLeft()) {
      return result;
    }

    return await _repository.createOrUpdate(client);
  }

  @override
  Future<Either<ClientRegistrationError, bool>> delete(Client client) async {
    final result = _validator.disableValidator(client);

    if (result.isLeft()) {
      return result;
    }

    return await _repository.delete(client);
  }

  @override
  Future<Either<ClientRegistrationError, List<Client>>> findAll() async {
    return await _repository.findAll();
  }

  @override
  Future<Either<ClientRegistrationError, Client>> findByID(String id) async {
    final result = _validator.findByIdValidator(id);

    if (result.isLeft()) {
      return result;
    }

    return await _repository.findByID(id);
  }
}
