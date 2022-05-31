import 'package:barbar_manager/modules/registration/domain/entities/client.dart';
import 'package:barbar_manager/modules/registration/domain/errors/registration_errors.dart';
import 'package:barbar_manager/modules/registration/domain/usecases/impl/client_usecase_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../repositories/repositories_mock.mocks.dart';

main() {
  final repository = MockClientRepository();
  final useCase = ClientUsecaseImpl(repository);

  setUpAll(() {
    final client = Client('Nunes', '19981436342', 'viny@gmail.com', true);
    when(repository.createOrUpdate(any))
        .thenAnswer((realInvocation) async => Right(client));

    when(repository.delete(any))
        .thenAnswer((realInvocation) async => const Right(true));
  });

  group('tests to create or update a client', () {
    test('should return a ClientError when name is empty', () async {
      final result = await useCase
          .createOrUpdate(Client('', '19981436342', 'viny@gmail.com', true));

      expect(result.fold(id, id), isA<RegistrationErrors>());
    });

    test('should return a ClientError when email is invalid', () async {
      final result = await useCase
          .createOrUpdate(Client('nunes', '19981436342', 'viny@', true));

      expect(result.fold(id, id), isA<RegistrationErrors>());
    });

    test('should return a ClientError when phone is invalid', () async {
      final result = await useCase.createOrUpdate(
          Client('nunes', '22222222a2', 'viny@gmail.com', true));

      expect(result.fold(id, id), isA<RegistrationErrors>());
    });

    test('should return a Client when is a valid client', () async {
      final result = await useCase.createOrUpdate(
          Client('viny', '19981436342', 'viny@gmail.com', true));

      expect(result.fold(id, id), isA<Client>());
      expect(result.fold((l) => null, (r) => r.name), equals('Nunes'));
    });
  });

  group('tests to delete a client', () {
    test('should return true when try to delete a client', () async {
      final result = await useCase
          .delete(Client('nunes', '19981436342', 'viny@hotmail.com', true));

      expect(result.fold(id, id), isA<bool>());
    });

    test(
        'should return Client Error when try to delete a client who is already disabled',
        () async {
      final result = await useCase
          .delete(Client('nunes', '19981436342', 'viny@hotmail.com', false));

      expect(result.fold(id, id), isA<RegistrationErrors>());
    });
  });
}
