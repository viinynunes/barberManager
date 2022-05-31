import 'package:barbar_manager/modules/registration/domain/entities/establishment.dart';
import 'package:barbar_manager/modules/registration/domain/errors/registration_errors.dart';
import 'package:dartz/dartz.dart';

abstract class EstablishmentUsecase {
  Future<Either<RegistrationErrors, Establishment>> createOrUpdate(
      Establishment establishment);
}
