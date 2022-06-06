import 'package:barbar_manager/modules/registration/domain/entities/item.dart';
import 'package:barbar_manager/modules/registration/domain/errors/registration_errors.dart';
import 'package:barbar_manager/modules/registration/domain/repositories/item_repository.dart';
import 'package:barbar_manager/modules/registration/domain/usecases/item_usecase.dart';
import 'package:barbar_manager/modules/registration/domain/usecases/validations/validate_item_fields.dart';
import 'package:dartz/dartz.dart';

class ItemUsecaseImpl implements ItemUsecase {
  final ItemRepository _repository;

  ItemUsecaseImpl(this._repository);

  @override
  Future<Either<RegistrationErrors, Item>> createOrUpdate(Item item) async {
    final validator = ValidateItemFields.createOrUpdateValidation(item);

    if (validator.isLeft()) {
      return validator;
    }

    return await _repository.createOrUpdate(item);
  }

  @override
  Future<Either<RegistrationErrors, bool>> disable(Item item) async {
    final validator = ValidateItemFields.disableValidation(item);

    if (validator.isLeft()) {
      return validator;
    }

    return await _repository.disable(item);
  }
}
