import 'package:barbar_manager/modules/registration/domain/entities/department.dart';
import 'package:barbar_manager/modules/registration/domain/errors/registration_errors.dart';
import 'package:barbar_manager/modules/registration/domain/repositories/department_repository.dart';
import 'package:barbar_manager/modules/registration/domain/usecases/department_usecase.dart';
import 'package:barbar_manager/modules/registration/domain/validations/validate_department_fields.dart';
import 'package:dartz/dartz.dart';

class DepartmentUsecaseImpl implements DepartmentUsecase {
  final DepartmentRepository _repository;

  DepartmentUsecaseImpl(this._repository);

  @override
  Future<Either<RegistrationErrors, Department>> createOrUpdate(
      Department department) async {
    final validator =
        ValidateDepartmentFields.createOrUpdateValidation(department);

    if (validator.isLeft()) {
      return validator;
    }

    return await _repository.createOrUpdate(department);
  }

  @override
  Future<Either<RegistrationErrors, bool>> disable(Department department) {
    // TODO: implement disable
    throw UnimplementedError();
  }
}
