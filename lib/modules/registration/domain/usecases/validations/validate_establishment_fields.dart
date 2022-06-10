import 'package:barbar_manager/modules/registration/domain/entities/establishment.dart';
import 'package:barbar_manager/modules/registration/domain/errors/registration_errors.dart';
import 'package:dartz/dartz.dart';
import 'package:string_validator/string_validator.dart';

class ValidateEstablishmentFields {
  static Either<EstablishmentRegistrationError, Establishment>
      createOrUpdateValidation(Establishment establishment) {
    if (establishment.name.isEmpty || establishment.name.length < 2) {
      return Left(EstablishmentRegistrationError('Invalid name'));
    }

    if (!isEmail(establishment.email)) {
      return Left(EstablishmentRegistrationError('Invalid email'));
    }

    if (establishment.description.isEmpty) {
      return Left(EstablishmentRegistrationError('Invalid description'));
    }

    if (establishment.imgUrl.isEmpty) {
      return Left(EstablishmentRegistrationError('Invalid image url'));
    }

    if (establishment.openTime != null) {
      if (establishment.openTime!.hour.isNegative ||
          establishment.openTime!.minute.isNegative) {
        return Left(
            EstablishmentRegistrationError('Open Time cannot be negative'));
      }
    }

    if (establishment.closeTime != null) {
      if (establishment.closeTime!.hour.isNegative ||
          establishment.closeTime!.minute.isNegative) {
        return Left(
            EstablishmentRegistrationError('Close Time cannot be negative'));
      }
    }

    return Right(establishment);
  }
}
