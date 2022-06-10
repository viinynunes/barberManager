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

  late Establishment establishmentTest;

  setUp(() {
    establishmentTest = Establishment(
        'aaa',
        'taurus',
        'taurus@gmail.com',
        'taurus barber shop',
        'https://google.images.com/taurus',
        DateTime(2020, 05, 10, 08, 00),
        DateTime(2020, 05, 10, 18, 30));

    when(repository.createOrUpdate(any))
        .thenAnswer((realInvocation) async => Right(establishmentTest));
  });

  group('testes to create or update establishment usecase', () {
    test('should return a establishment when everything is correct', () async {
      final result = await usecase.createOrUpdate(establishmentTest);

      expect(result.fold(id, id), isA<Establishment>());
      expect(result.fold((l) => null, (r) => r.name), equals('taurus'));
    });

    test(
        'should return a establishment when open and close time is null',
        () async {
      establishmentTest.openTime = null;
      establishmentTest.closeTime = null;

      final result = await usecase.createOrUpdate(establishmentTest);

      expect(result.fold(id, id), isA<Establishment>());
      expect(result.fold((l) => null, (r) => r.name), equals('taurus'));
    });

    test('should return a EstablishmentRegistrationError when name is invalid',
        () async {
      establishmentTest.name = '';
      var result = await usecase.createOrUpdate(establishmentTest);

      expect(result.fold(id, id), isA<EstablishmentRegistrationError>());

      establishmentTest.name = 'T';

      result = await usecase.createOrUpdate(establishmentTest);

      expect(result.fold(id, id), isA<EstablishmentRegistrationError>());
    });

    test('should return a EstablishmentRegistrationError when email is invalid',
        () async {
      establishmentTest.email = 'teste@.com';

      var result = await usecase.createOrUpdate(establishmentTest);

      expect(result.fold(id, id), isA<EstablishmentRegistrationError>());

      establishmentTest.email = 'teste@hotmail.';

      result = await usecase.createOrUpdate(establishmentTest);

      expect(result.fold(id, id), isA<EstablishmentRegistrationError>());
    });

    test(
        'should return a EstablishmentRegistrationError when description is invalid',
        () async {
      establishmentTest.description = '';

      var result = await usecase.createOrUpdate(establishmentTest);

      expect(result.fold(id, id), isA<EstablishmentRegistrationError>());
    });

    test(
        'should return a EstablishmentRegistrationError when img url is invalid',
        () async {
      establishmentTest.imgUrl = '';
      var result = await usecase.createOrUpdate(establishmentTest);

      expect(result.fold(id, id), isA<EstablishmentRegistrationError>());
    });

    test(
        'should return a EstablishmentRegistrationError when open time is negative',
        () async {
      establishmentTest.openTime = null;
    });
  });
}
