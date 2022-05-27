import 'package:dartz/dartz.dart';

import '../entities/client.dart';
import '../errors/registration_errors.dart';

abstract class ClientRepository {
  Future<Either<RegistrationErrors, Client>> createOrUpdate(Client client);

  Future<Either<RegistrationErrors, bool>> delete(Client client);
}
