import 'package:barbar_manager/modules/registration/domain/entities/user.dart';
import 'package:barbar_manager/modules/registration/domain/errors/registration_errors.dart';
import 'package:dartz/dartz.dart';
import 'package:string_validator/string_validator.dart';

class ValidateUserFields {
  static Either<UserRegistrationError, User> createOrUpdateValidator(
      User user) {
    if (!isEmail(user.email)) {
      return Left(UserRegistrationError('Invalid Email'));
    }

    if (user.fullName.isEmpty || user.fullName.length < 2) {
      return Left(UserRegistrationError('Invalid Full Name'));
    }

    if (user.password.isEmpty || user.password.length < 6) {
      return Left(UserRegistrationError('Invalid Password'));
    }

    return Right(user);
  }

  static Either<UserRegistrationError, bool> disableValidator(User user) {
    if (user.enabled == false) {
      return Left(UserRegistrationError('User already disabled'));
    }

    if (user.id.isEmpty) {
      return Left(UserRegistrationError('User without id in database'));
    }

    return const Right(true);
  }
}
