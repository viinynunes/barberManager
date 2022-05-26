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
  Future<Either<ClientErrors, Client>> create(Client client) async {
    final validator = ValidateClientFields.validate(client);

    if (validator.isLeft()) {
      return validator;
    }

    return await _repository.create(client);
  }
}
