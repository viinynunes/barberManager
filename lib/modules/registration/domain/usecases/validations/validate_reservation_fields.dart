import 'package:barbar_manager/modules/registration/domain/entities/item.dart';
import 'package:barbar_manager/modules/registration/domain/entities/reservation.dart';
import 'package:barbar_manager/modules/registration/domain/usecases/validations/validate_item_fields.dart';
import 'package:dartz/dartz.dart';

import '../../errors/registration_errors.dart';

class ValidateReservationFields extends ValidateItemFields {
  Either<ItemRegistrationError, Item> registrationHourValidation(
      Reservation reservation) {
    if (reservation.establishment.openTime != null &&
        reservation.establishment.closeTime != null) {
      final reservationHour = reservation.reservationDate;

      if (reservationHour.hour >= reservation.establishment.openTime!.hour) {
        if (reservationHour.hour <= reservation.establishment.openTime!.hour &&
            reservationHour.minute <
                reservation.establishment.openTime!.minute) {
          return Left(ItemRegistrationError(
              'ReservationDate cannot be before establishment open time'));
        }
      } else {
        return Left(ItemRegistrationError(
            'ReservationDate cannot be before establishment open time'));
      }

      if (reservationHour.hour <= reservation.establishment.closeTime!.hour) {
        if (reservationHour.hour >= reservation.establishment.closeTime!.hour &&
            reservationHour.minute >
                reservation.establishment.closeTime!.minute) {
          return Left(ItemRegistrationError(
              'ReservationDate cannot be before establishment close time'));
        }
      } else {
        return Left(ItemRegistrationError(
            'ReservationDate cannot be before establishment close time'));
      }
    }

    if (reservation.reservationDate.year == 0 ||
        reservation.reservationDate.month == 0 ||
        reservation.reservationDate.day == 0) {
      return Left(ItemRegistrationError('Invalid reservation date'));
    }

    if (reservation.reservationDate.hour == 0) {
      return Left(ItemRegistrationError('Hour cannot be empty'));
    }

    if (reservation.reservationDate.isBefore(DateTime.now())) {
      return Left(ItemRegistrationError('Date cannot be before now'));
    }

    return Right(reservation);
  }
}
