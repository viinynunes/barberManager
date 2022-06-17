import 'package:barbar_manager/modules/registration/domain/entities/establishment.dart';
import 'package:barbar_manager/modules/registration/domain/entities/user.dart';
import 'package:barbar_manager/modules/registration/domain/errors/registration_errors.dart';
import 'package:barbar_manager/modules/registration/domain/usecases/impl/user_usercase_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../repositories/repositories_mock.mocks.dart';

main() {
  final repository = MockUserRepository();
  final usecase = UserUsecaseImpl(repository);
  late Establishment establishment;
  late User user;

  setUp(() {
    establishment = Establishment(
        'id',
        'tourus',
        'taurus@gmail.com',
        'taurus barbar shop',
        'https://google.images.com/barber',
        DateTime.now(),
        DateTime.now());

    user = User(
        'id', 'Vinicius Nunes', 'nunes@gmail.com', '123456', establishment, true);

    when(repository.createOrUpdate(any))
        .thenAnswer((realInvocation) async => Right(user));

    when(repository.disable(any))
        .thenAnswer((realInvocation) async => const Right(true));
  });

  group('tests to create or update method on usecase', () {
    test('should return a user when everything is validated on usecase',
        () async {
      final result = await usecase.createOrUpdate(user);

      expect(result.fold(id, id), isA<User>());
      expect(result.fold((l) => null, (r) => r.fullName),
          equals('Vinicius Nunes'));
    });

    test('should return a UserRegistrationError when email is invalid',
        () async {
      user.email = 'ze@gmail';

      var result = await usecase.createOrUpdate(user);

      expect(result.fold(id, id), isA<UserRegistrationError>());
      expect(
          result.fold((l) => l.message, (r) => null), equals('Invalid Email'));

      user.email = 'zegmail.com';

      result = await usecase.createOrUpdate(user);

      expect(result.fold(id, id), isA<UserRegistrationError>());
      expect(
          result.fold((l) => l.message, (r) => null), equals('Invalid Email'));
    });

    test('should return a UserRegistrationError when fullName is invalid',
        () async {
      user.fullName = 'A';

      var result = await usecase.createOrUpdate(user);

      expect(result.fold(id, id), isA<UserRegistrationError>());
      expect(result.fold((l) => l.message, (r) => null),
          equals('Invalid Full Name'));

      user.fullName = '';

      result = await usecase.createOrUpdate(user);

      expect(result.fold(id, id), isA<UserRegistrationError>());
      expect(result.fold((l) => l.message, (r) => null),
          equals('Invalid Full Name'));
    });

    test('should return a UserRegistrationError when password is invalid',
        () async {
      user.password = '12345';

      var result = await usecase.createOrUpdate(user);

      expect(result.fold(id, id), isA<UserRegistrationError>());
      expect(result.fold((l) => l.message, (r) => null),
          equals('Invalid Password'));

      user.password = 'aa';

      result = await usecase.createOrUpdate(user);

      expect(result.fold(id, id), isA<UserRegistrationError>());
      expect(result.fold((l) => l.message, (r) => null),
          equals('Invalid Password'));

      user.password = '';

      result = await usecase.createOrUpdate(user);

      expect(result.fold(id, id), isA<UserRegistrationError>());
      expect(result.fold((l) => l.message, (r) => null),
          equals('Invalid Password'));
    });
  });

  group('tests to disable user on usecase', () {
    test('should disable a valid user', () async {
      final result = await usecase.disable(user);

      expect(result.fold(id, id), isA<bool>());
      expect(result.fold((l) => null, (r) => r), equals(true));
    });

    test('should return a UserRegistrationError when ID is invalid', () async {
      user.id = '';

      final result = await usecase.disable(user);

      expect(result.fold(id, id), isA<UserRegistrationError>());
      expect(result.fold((l) => l.message, (r) => null),
          equals('User without id in database'));
    });

    test('should return a UserRegistrationError when enabled is already false',
        () async {
      user.enabled = false;

      final result = await usecase.disable(user);

      expect(result.fold(id, id), isA<UserRegistrationError>());
      expect(result.fold((l) => l.message, (r) => null),
          equals('User already disabled'));
    });
  });
}
