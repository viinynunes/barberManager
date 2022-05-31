import 'package:dartz/dartz.dart';

import '../entities/establishment.dart';
import '../errors/registration_errors.dart';

abstract class EstablishmentRepository {
  Future<Either<RegistrationErrors, Establishment>> createOrUpdate(
      Establishment establishment);
}
