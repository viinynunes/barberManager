import 'package:barbar_manager/modules/registration/domain/entities/item.dart';
import 'package:barbar_manager/modules/registration/domain/entities/reservation.dart';
import 'package:barbar_manager/modules/registration/domain/errors/registration_errors.dart';
import 'package:barbar_manager/modules/registration/domain/repositories/item_repository.dart';
import 'package:barbar_manager/modules/registration/domain/usecases/item_usecase.dart';
import 'package:barbar_manager/modules/registration/domain/usecases/validations/validate_reservation_fields.dart';
import 'package:dartz/dartz.dart';

class ReservationItemUsecaseImpl implements ItemUsecase {
  final ItemRepository _repository;
  final _validator = ValidateReservationFields();

  ReservationItemUsecaseImpl(this._repository);

  @override
  Future<Either<ItemRegistrationError, Item>> createOrUpdate(
      Item reservationItem) async {
    var result = _validator.createOrUpdateValidation(reservationItem);

    if (result.isLeft()) {
      return result;
    }

    result =
        _validator.registrationHourValidation(reservationItem as Reservation);

    if (result.isLeft()) {
      return result;
    }

    return await _repository.createOrUpdate(reservationItem);
  }

  @override
  Future<Either<ItemRegistrationError, bool>> disable(Item reservation) async {
    var result = _validator.disableValidation(reservation);

    if (result.isLeft()) {
      return result;
    }

    return await _repository.disable(reservation);
  }
}
