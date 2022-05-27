import 'package:dartz/dartz.dart';

import '../entities/client.dart';
import '../errors/client_errors.dart';

abstract class ClientRepository {
  Future<Either<ClientErrors, Client>> createOrUpdate(Client client);

  Future<Either<ClientErrors, bool>> delete(Client client);
}
