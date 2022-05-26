import 'package:barbar_manager/modules/registration/client/domain/entities/client.dart';
import 'package:barbar_manager/modules/registration/client/domain/errors/client_errors.dart';
import 'package:barbar_manager/modules/registration/client/domain/repositories/client_repository.dart';
import 'package:barbar_manager/modules/registration/client/domain/usecases/client_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:string_validator/string_validator.dart';

class ClientUsecaseImpl implements ClientUsecase {
  final ClientRepository _repository;

  ClientUsecaseImpl(this._repository);

  @override
  Future<Either<ClientErrors, Client>> call(Client client) async {
    if (!isEmail(client.email)) {
      return Left(ClientValidatorError('Invalid Email'));
    }

    if (client.name.isEmpty) {
      return Left(ClientValidatorError('Invalid Name'));
    }

    if (client.phoneNumber.isEmpty || client.phoneNumber.length != 11) {
      return Left(ClientValidatorError('Invalid Phone Number'));
    }

    return await _repository.create(client);
  }
}
