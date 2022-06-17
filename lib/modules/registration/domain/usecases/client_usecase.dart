import 'package:dartz/dartz.dart';

import '../entities/client.dart';
import '../errors/registration_errors.dart';

abstract class ClientUsecase {
  Future<Either<ClientRegistrationError, Client>> createOrUpdate(Client client);

  Future<Either<ClientRegistrationError, bool>> delete(Client client);

  Future<Either<ClientRegistrationError, List<Client>>> findAll();

  Future<Either<ClientRegistrationError, Client>> findByID(String id);
}
