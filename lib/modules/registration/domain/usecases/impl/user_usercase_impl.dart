import 'package:barbar_manager/modules/registration/domain/entities/user.dart';
import 'package:barbar_manager/modules/registration/domain/errors/registration_errors.dart';
import 'package:barbar_manager/modules/registration/domain/repositories/user_repository.dart';
import 'package:barbar_manager/modules/registration/domain/usecases/user_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../usecases/validations/validate_user_fields.dart';

class UserUsecaseImpl implements UserUsecase {
  final UserRepository _repository;

  UserUsecaseImpl(this._repository);

  @override
  Future<Either<UserRegistrationError, User>> createOrUpdate(User user) async {
    final validator = ValidateUserFields.createOrUpdateValidator(user);

    if (validator.isLeft()) {
      return validator;
    }

    return _repository.createOrUpdate(user);
  }

  @override
  Future<Either<UserRegistrationError, bool>> disable(User user) async {
    final validator = ValidateUserFields.disableValidator(user);

    if (validator.isLeft()) {
      return validator;
    }

    return _repository.disable(user);
  }
}
