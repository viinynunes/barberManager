import 'package:barbar_manager/modules/registration/domain/entities/item.dart';
import 'package:barbar_manager/modules/registration/domain/entities/reservation.dart';
import 'package:barbar_manager/modules/registration/domain/usecases/validations/validate_item_fields.dart';
import 'package:dartz/dartz.dart';

import '../../errors/registration_errors.dart';

class ValidateReservationFields extends ValidateItemFields {
  Either<ItemRegistrationError, Item> registrationHourValidation(
      Reservation reservation) {
    if (reservation.reservationDate.isBefore(DateTime.now())) {
      return Left(ItemRegistrationError('Date cannot be before now'));
    }

    if (reservation.reservationDate.day.isNegative ||
        reservation.reservationDate.month.isNegative ||
        reservation.reservationDate.year.isNegative) {
      return Left(ItemRegistrationError('Date cannot be negative'));
    }

    if (reservation.reservationDate.hour.isNegative ||
        reservation.reservationDate.minute.isNegative) {
      return Left(ItemRegistrationError('Hour or minute cannot be negative'));
    }

    if (reservation.reservationDate.year == 0 ||
        reservation.reservationDate.month == 0 ||
        reservation.reservationDate.day == 0) {
      return Left(ItemRegistrationError('Invalid reservation date'));
    }

    if (reservation.reservationDate.hour == 0) {
      return Left(ItemRegistrationError('Hour cannot be empty'));
    }

    return Right(reservation);
  }
}
