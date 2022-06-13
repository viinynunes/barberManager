import 'package:barbar_manager/modules/registration/domain/entities/department.dart';
import 'package:barbar_manager/modules/registration/domain/errors/registration_errors.dart';
import 'package:barbar_manager/modules/registration/domain/usecases/impl/department_usecase_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../repositories/repositories_mock.mocks.dart';

main() {
  final repository = MockDepartmentRepository();
  final usecase = DepartmentUsecaseImpl(repository);
  late Department department;

  setUpAll(() {
    when(repository.createOrUpdate(any))
        .thenAnswer((realInvocation) async => Right(department));

    when(repository.disable(any))
        .thenAnswer((realInvocation) async => const Right(true));
  });

  setUp(() {
    department = Department('id', 'Shop', 'Products in sale', true);
  });

  group('tests to create or update department usecase', () {
    test(
        'should return a department from repository when everything is correct',
        () async {
      final result = await usecase.createOrUpdate(department);

      expect(result.fold(id, id), isA<Department>());
      expect(result.fold((l) => null, (r) => r.name), equals('Shop'));
    });

    test('should return a DepartmentRegistrationError when name is invalid',
        () async {
      department.name = '';

      var result = await usecase.createOrUpdate(department);

      expect(result.fold(id, id), isA<DepartmentRegistrationError>());

      department.name = '1';

      result = await usecase.createOrUpdate(department);

      expect(result.fold(id, id), isA<DepartmentRegistrationError>());
      expect(result.fold((l) => l.message, (r) => null), equals('Invalid name'));
    });

    test(
        'should return a DepartmentRegistrationError when description is invalid',
        () async {
      department.description = '';

      final result = await usecase.createOrUpdate(department);

      expect(result.fold(id, id), isA<DepartmentRegistrationError>());
      expect(result.fold((l) => l.message, (r) => null), equals('Invalid description'));
    });
  });
}
