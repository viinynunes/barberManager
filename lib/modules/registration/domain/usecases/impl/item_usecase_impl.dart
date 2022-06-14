import 'package:barbar_manager/modules/registration/domain/entities/item.dart';
import 'package:barbar_manager/modules/registration/domain/errors/registration_errors.dart';
import 'package:barbar_manager/modules/registration/domain/repositories/item_repository.dart';
import 'package:barbar_manager/modules/registration/domain/usecases/item_usecase.dart';
import 'package:barbar_manager/modules/registration/domain/usecases/validations/validate_item_fields.dart';
import 'package:dartz/dartz.dart';

class ItemUsecaseImpl implements ItemUsecase {
  final ItemRepository _repository;
  final _validator = ValidateItemFields();

  ItemUsecaseImpl(this._repository);

  @override
  Future<Either<ItemRegistrationError, Item>> createOrUpdate(Item item) async {
    final result = _validator.createOrUpdateValidation(item);

    if (result.isLeft()) {
      return result;
    }

    return await _repository.createOrUpdate(item);
  }

  @override
  Future<Either<ItemRegistrationError, bool>> disable(Item item) async {
    final result = _validator.disableValidation(item);

    if (result.isLeft()) {
      return result;
    }

    return await _repository.disable(item);
  }
}
