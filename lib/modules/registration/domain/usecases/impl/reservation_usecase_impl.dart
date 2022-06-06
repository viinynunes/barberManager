import 'package:barbar_manager/modules/registration/domain/entities/item.dart';
import 'package:barbar_manager/modules/registration/domain/entities/reservation.dart';
import 'package:barbar_manager/modules/registration/domain/errors/registration_errors.dart';
import 'package:barbar_manager/modules/registration/domain/repositories/item_repository.dart';
import 'package:barbar_manager/modules/registration/domain/usecases/item_usecase.dart';
import 'package:barbar_manager/modules/registration/domain/validations/validate_item_fields.dart';
import 'package:barbar_manager/modules/registration/domain/validations/validate_reservation_fields.dart';
import 'package:dartz/dartz.dart';

class ReservationItemUsecaseImpl implements ItemUsecase {
  final ItemRepository _repository;

  ReservationItemUsecaseImpl(this._repository);

  @override
  Future<Either<RegistrationErrors, Item>> createOrUpdate(
      Item reservationItem) async {
    var validator =
        ValidateItemFields.createOrUpdateValidation(reservationItem);

    if (validator.isLeft()) {
      return validator;
    }

    validator = ValidateReservationFields.createOrUpdateValidation(
        reservationItem as Reservation);

    if (validator.isLeft()) {
      return validator;
    }

    return await _repository.createOrUpdate(reservationItem);
  }

  @override
  Future<Either<RegistrationErrors, bool>> disable(Item reservation) async {
    var validator = ValidateItemFields.disableValidation(reservation);

    if (validator.isLeft()) {
      return validator;
    }

    return await _repository.disable(reservation);
  }
}
