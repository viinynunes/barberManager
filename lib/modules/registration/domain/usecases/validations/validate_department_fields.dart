import 'package:barbar_manager/modules/registration/domain/entities/department.dart';
import 'package:barbar_manager/modules/registration/domain/errors/registration_errors.dart';
import 'package:dartz/dartz.dart';

class ValidateDepartmentFields {
  static Either<DepartmentRegistrationError, Department> createOrUpdateValidation(
      Department department) {
    if (department.name.isEmpty || department.name.length < 2) {
      return Left(DepartmentRegistrationError('Invalid name'));
    }

    if (department.description.isEmpty) {
      return Left(DepartmentRegistrationError('Invalid description'));
    }

    return Right(department);
  }
}
