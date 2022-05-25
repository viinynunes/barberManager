import 'package:barbar_manager/modules/registration/client/domain/entities/client.dart';
import 'package:barbar_manager/modules/registration/client/domain/errors/client_errors.dart';
import 'package:dartz/dartz.dart';

abstract class CreateClientUsecase {
  Future<Either<ClientErrors, Client>> call(Client client);
}
