import 'package:barbar_manager/modules/registration/domain/entities/item.dart';
import 'package:barbar_manager/modules/registration/domain/errors/registration_errors.dart';
import 'package:dartz/dartz.dart';

abstract class ItemRepository {
  Future<Either<RegistrationErrors, Item>> createOrUpdate(Item item);

  Future<Either<RegistrationErrors, bool>> disable(Item item);
}
