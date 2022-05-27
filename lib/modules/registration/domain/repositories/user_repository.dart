import 'package:barbar_manager/modules/registration/domain/entities/user.dart';
import 'package:barbar_manager/modules/registration/domain/errors/registration_errors.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<UserRegistrationError, User>> createOrUpdate(User user);
  Future<Either<UserRegistrationError, bool>> disable(User user);
}