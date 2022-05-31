import 'package:barbar_manager/modules/registration/domain/entities/establishment.dart';
import 'package:barbar_manager/modules/registration/domain/errors/registration_errors.dart';
import 'package:barbar_manager/modules/registration/domain/repositories/establishment_repository.dart';
import 'package:barbar_manager/modules/registration/domain/usecases/establishment_usecase.dart';
import 'package:barbar_manager/modules/registration/domain/utils/validate_establishment_fields.dart';
import 'package:dartz/dartz.dart';

class EstablishmentUsecaseImpl implements EstablishmentUsecase {
  final EstablishmentRepository _repository;

  EstablishmentUsecaseImpl(this._repository);

  @override
  Future<Either<RegistrationErrors, Establishment>> createOrUpdate(
      Establishment establishment) async {
    final validator =
        ValidateEstablishmentFields.createOrUpdateValidation(establishment);

    if (validator.isLeft()) {
      return validator;
    }

    return _repository.createOrUpdate(establishment);
  }
}
