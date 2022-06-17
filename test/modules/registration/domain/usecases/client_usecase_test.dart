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
  late Client client;

  setUp(() {
    client = Client('', 'Nunes', '19981436342', 'viny@gmail.com', true);
    when(repository.createOrUpdate(any))
        .thenAnswer((realInvocation) async => Right(client));

    when(repository.delete(any))
        .thenAnswer((realInvocation) async => const Right(true));

    when(repository.findByID(any))
        .thenAnswer((realInvocation) async => Right(client));
  });

  group('tests to create or update a client', () {
    test('should return a Client when is a valid client', () async {
      final result = await useCase.createOrUpdate(client);

      expect(result.fold(id, id), isA<Client>());
      expect(result.fold((l) => null, (r) => r.name), equals('Nunes'));
    });

    test('should return a ClientError when name is empty', () async {
      client.name = '';

      final result = await useCase.createOrUpdate(client);

      expect(result.fold(id, id), isA<RegistrationErrors>());
      expect(
          result.fold((l) => l.message, (r) => null), equals('Invalid Name'));
    });

    test('should return a ClientError when email is invalid', () async {
      client.email = 'viny@';

      final result = await useCase.createOrUpdate(client);

      expect(result.fold(id, id), isA<RegistrationErrors>());
      expect(
          result.fold((l) => l.message, (r) => null), equals('Invalid Email'));
    });

    test('should return a ClientError when phone is invalid', () async {
      client.phoneNumber = '22222222a2';

      final result = await useCase.createOrUpdate(client);

      expect(result.fold(id, id), isA<RegistrationErrors>());
      expect(result.fold((l) => l.message, (r) => null),
          equals('Invalid Phone Number'));
    });
  });

  group('tests to delete a client', () {
    test('should return true when try to delete a client', () async {
      final result = await useCase.delete(client);

      expect(result.fold(id, id), isA<bool>());
      expect(result.fold(id, id), equals(true));
    });

    test(
        'should return Client Error when try to delete a client who is already disabled',
        () async {
      client.enabled = false;

      final result = await useCase.delete(client);

      expect(result.fold(id, id), isA<ClientRegistrationError>());
      expect(result.fold((l) => l.message, (r) => null),
          equals('Client already disabled'));
    });
  });

  group('tests to client findByID method', () {
    test('should return a client', () async {
      final result = await useCase.findByID('aaaaaa');

      expect(result.fold(id, id), isA<Client>());
      expect(result.fold((l) => null, (r) => r.name), equals('Nunes'));
    });

    test('should return a ClientRegistrationError when ID is empty', () async {
      final result = await useCase.findByID('');

      expect(result.fold(id, id), isA<ClientRegistrationError>());
      expect(result.fold((l) => l.message, (r) => null),
          equals('Client ID is empty'));
    });
  });
}
