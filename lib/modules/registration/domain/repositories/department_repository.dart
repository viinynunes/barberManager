import 'package:barbar_manager/modules/registration/domain/entities/department.dart';
import 'package:barbar_manager/modules/registration/domain/errors/registration_errors.dart';
import 'package:dartz/dartz.dart';

abstract class DepartmentRepository {
  Future<Either<DepartmentRegistrationError, Department>> createOrUpdate(
      Department department);

  Future<Either<RegistrationErrors, bool>> disable(Department department);
}
