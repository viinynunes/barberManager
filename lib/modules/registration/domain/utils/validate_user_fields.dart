import 'package:barbar_manager/modules/registration/domain/entities/user.dart';
import 'package:barbar_manager/modules/registration/domain/errors/registration_errors.dart';
import 'package:dartz/dartz.dart';
import 'package:string_validator/string_validator.dart';

class ValidateUserFields {

  static Either<UserRegistrationError, User> validate(User user){
    if (!isEmail(user.email)){
      return Left(UserRegistrationError('Invalid Email'));
    }

    if(user.password.isEmpty || user.password.length < 6){
      return Left(UserRegistrationError('Invalid Password'));
    }

    return Right(user);
  }
}