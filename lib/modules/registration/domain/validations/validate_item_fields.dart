import 'package:barbar_manager/modules/registration/domain/entities/item.dart';
import 'package:barbar_manager/modules/registration/domain/errors/registration_errors.dart';
import 'package:dartz/dartz.dart';

class ValidateItemFields {
  static Either<ItemRegistrationError, Item> createOrUpdateValidation(
      Item item) {
    if (item.name.isEmpty || item.name.length < 2) {
      return Left(ItemRegistrationError('Invalid Name'));
    }

    if (item.description.isEmpty) {
      return Left(ItemRegistrationError('Invalid Description'));
    }

    if (item.price.isNegative) {
      return Left(ItemRegistrationError('Price cannot be negative'));
    }

    if (item.imgUrl.isEmpty) {
      return Left(ItemRegistrationError('Invalid image url'));
    }

    if (item.registrationDate.hour.isNegative ||
        item.registrationDate.minute.isNegative ||
        item.registrationDate.second.isNegative) {
      return Left(ItemRegistrationError('Invalid Registration Date'));
    }

    if (item.department.id.isEmpty || !item.department.enabled) {
      return Left(ItemRegistrationError('Invalid Department'));
    }

    return Right(item);
  }

  static Either<ItemRegistrationError, bool> disableValidation(Item item) {
    if (item.id.isEmpty) {
      return Left(ItemRegistrationError('Invalid ID'));
    }

    if (!item.enabled) {
      return Left(ItemRegistrationError('Item already disabled'));
    }

    return const Right(true);
  }
}
