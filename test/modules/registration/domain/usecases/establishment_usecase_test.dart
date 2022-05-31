import 'package:barbar_manager/modules/registration/domain/entities/establishment.dart';
import 'package:barbar_manager/modules/registration/domain/errors/registration_errors.dart';
import 'package:barbar_manager/modules/registration/domain/usecases/impl/establishment_usecase_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../repositories/repositories_mock.mocks.dart';

main() {
  final repository = MockEstablishmentRepository();
  final usecase = EstablishmentUsecaseImpl(repository);

  setUpAll(() {
    final establishment = Establishment('aaa', 'taurus', 'taurus@gmail.com',
        'taurus barber shop', 'https://google.images.com/taurus');
    when(repository.createOrUpdate(any))
        .thenAnswer((realInvocation) async => Right(establishment));
  });

  group('testes to create or update establishment usecase', () {
    test('should return a establishment when everything is correct', () async {
      final result = await usecase.createOrUpdate(Establishment('id', 'Bulls',
          'teste@hotmail.com', 'bulls barber shop', 'https://bulls.com'));

      expect(result.fold(id, id), isA<Establishment>());
      expect(result.fold((l) => null, (r) => r.name), equals('taurus'));
    });

    test('should return a EstablishmentRegistrationError when name is invalid',
        () async {
      var result = await usecase.createOrUpdate(Establishment('id', '',
          'teste@hotmail.com', 'bulls barber shop', 'https://bulls.com'));

      expect(result.fold(id, id), isA<EstablishmentRegistrationError>());

      result = await usecase.createOrUpdate(Establishment('id', 'T',
          'teste@hotmail.com', 'bulls barber shop', 'https://bulls.com'));

      expect(result.fold(id, id), isA<EstablishmentRegistrationError>());
    });

    test('should return a EstablishmentRegistrationError when email is invalid',
        () async {
      var result = await usecase.createOrUpdate(Establishment('id', 'Taurus',
          'teste@.com', 'bulls barber shop', 'https://bulls.com'));

      expect(result.fold(id, id), isA<EstablishmentRegistrationError>());

      result = await usecase.createOrUpdate(Establishment('id', 'Taurus',
          'teste@hotmail.', 'bulls barber shop', 'https://bulls.com'));

      expect(result.fold(id, id), isA<EstablishmentRegistrationError>());
    });

    test(
        'should return a EstablishmentRegistrationError when description is invalid',
        () async {
      var result = await usecase.createOrUpdate(Establishment(
          'id', 'Taurus', 'taurus@gmail.com', '', 'https://bulls.com'));

      expect(result.fold(id, id), isA<EstablishmentRegistrationError>());
    });

    test(
        'should return a EstablishmentRegistrationError when img url is invalid',
        () async {
      var result = await usecase.createOrUpdate(Establishment(
          'id', 'Taurus', 'taurus@gmail.com', 'taurus barber shop', ''));

      expect(result.fold(id, id), isA<EstablishmentRegistrationError>());
    });
  });
}
