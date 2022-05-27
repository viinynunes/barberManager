import 'package:barbar_manager/modules/registration/domain/entities/user.dart';
import 'package:barbar_manager/modules/registration/domain/errors/registration_errors.dart';
import 'package:barbar_manager/modules/registration/domain/repositories/user_repository.dart';
import 'package:barbar_manager/modules/registration/domain/usecases/impl/user_usercase_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_usecase_test.mocks.dart';

@GenerateMocks([UserRepository])
main() {
  final repository = MockUserRepository();
  final usecase = UserUsecaseImpl(repository);

  setUpAll(() {
    final user = User('id', 'Vinicius Nunes', 'nunes@gmail.com', '123', true);
    when(repository.createOrUpdate(any))
        .thenAnswer((realInvocation) async => Right(user));

    when(repository.disable(user))
        .thenAnswer((realInvocation) async => const Right(true));
  });

  group('tests to create or update method on usecase', () {
    test('should return a user when everything is validated on usecase',
        () async {
      final result = await usecase.createOrUpdate(
          User('id', 'ze ramalho', 'ze@gmail.com', '456786', true));

      expect(result.fold(id, id), isA<User>());
      expect(result.fold((l) => null, (r) => r.fullName),
          equals('Vinicius Nunes'));
    });

    test('should return a UserRegistrationError when email is invalid',
        () async {
      var result = await usecase
          .createOrUpdate(User('id', 'ze ramalho', 'ze@gmail', '456786', true));

      expect(result.fold(id, id), isA<UserRegistrationError>());

      result = await usecase.createOrUpdate(
          User('id', 'ze ramalho', 'zegmail.com', '456786', true));

      expect(result.fold(id, id), isA<UserRegistrationError>());
    });

    test('should return a UserRegistrationError when fullName is invalid', () async {
      var result = await usecase.createOrUpdate(User('id', 'A', 'viny@gmail.com', '123456', true));
      expect(result.fold(id, id), isA<UserRegistrationError>());

      result = await usecase.createOrUpdate(User('id', '', 'viny@gmail.com', '123456', true));
      expect(result.fold(id, id), isA<UserRegistrationError>());
    });

    test('should return a UserRegistrationError when password is invalid',
        () async {
      var result = await usecase.createOrUpdate(
          User('id', 'ze ramalho', 'ze@gmail.com', '12345', true));

      expect(result.fold(id, id), isA<UserRegistrationError>());

      result = await usecase
          .createOrUpdate(User('id', 'ze ramalho', 'ze@gmail.com', 'aa', true));

      expect(result.fold(id, id), isA<UserRegistrationError>());

      result = await usecase
          .createOrUpdate(User('id', 'ze ramalho', 'ze@gmail.com', '', true));

      expect(result.fold(id, id), isA<UserRegistrationError>());
    });
  });
}
