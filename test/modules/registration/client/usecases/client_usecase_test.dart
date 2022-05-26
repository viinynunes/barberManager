import 'package:barbar_manager/modules/registration/client/domain/entities/client.dart';
import 'package:barbar_manager/modules/registration/client/domain/errors/client_errors.dart';
import 'package:barbar_manager/modules/registration/client/domain/repositories/client_repository.dart';
import 'package:barbar_manager/modules/registration/client/domain/usecases/client_usecase_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'client_usecase_test.mocks.dart';

@GenerateMocks([ClientRepository])
main() {
  final repository = MockClientRepository();
  final useCase = ClientUsecaseImpl(repository);

  setUpAll(() {
    final client = Client('Nunes', '19981436342', 'viny@gmail.com');
    when(repository.create(any))
        .thenAnswer((realInvocation) async => Right(client));
  });

  group('tests to create a new client', () {
    test('should return a ClientError when name is empty', () async {
      final result = await useCase(Client('', '19981436342', 'viny@gmail.com'));

      expect(result.fold(id, id), isA<ClientErrors>());
    });

    test('should return a ClientError when email is invalid', () async {
      final result = await useCase(Client('nunes', '19981436342', 'viny@'));

      expect(result.fold(id, id), isA<ClientErrors>());
    });

    test('should return a ClientError when phone is invalid', () async {
      final result =
          await useCase(Client('nunes', '22222222a2', 'viny@gmail.com'));

      expect(result.fold(id, id), isA<ClientErrors>());
    });

    test('should return a Client when is a valid client', () async {
      final result =
          await useCase(Client('viny', '19981436342', 'viny@gmail.com'));

      expect(result.fold(id, id), isA<Client>());
      expect(result.fold((l) => null, (r) => r.name), equals('Nunes'));
    });
  });
}
