import 'package:barbar_manager/modules/registration/client/domain/entities/client.dart';
import 'package:barbar_manager/modules/registration/client/domain/errors/client_errors.dart';
import 'package:barbar_manager/modules/registration/client/domain/repositories/client_repository.dart';
import 'package:barbar_manager/modules/registration/client/domain/usecases/client_usecase.dart';
import 'package:barbar_manager/modules/registration/client/domain/utils/validate_client_fields.dart';
import 'package:dartz/dartz.dart';

class ClientUsecaseImpl implements ClientUsecase {
  final ClientRepository _repository;

  ClientUsecaseImpl(this._repository);

  @override
  Future<Either<ClientErrors, Client>> createOrUpdate(Client client) async {
    final validator = ValidateClientFields.validate(client);

    if (validator.isLeft()) {
      return validator;
    }

    return await _repository.createOrUpdate(client);
  }

  @override
  Future<Either<ClientErrors, bool>> delete(Client client) async {
    if (!client.enabled) {
      return Left(ClientValidatorError('Client already disabled'));
    }

    return await _repository.delete(client);
  }
}
