import 'package:barbar_manager/modules/registration/domain/entities/department.dart';
import 'package:barbar_manager/modules/registration/domain/entities/establishment.dart';
import 'package:barbar_manager/modules/registration/domain/entities/item.dart';
import 'package:barbar_manager/modules/registration/domain/entities/reservation.dart';
import 'package:barbar_manager/modules/registration/domain/errors/registration_errors.dart';
import 'package:barbar_manager/modules/registration/domain/usecases/impl/reservation_usecase_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../repositories/repositories_mock.mocks.dart';

main() {
  final repository = MockItemRepository();
  final usecase = ReservationItemUsecaseImpl(repository);
  late Department department;
  late Establishment establishment;
  late Reservation reservation;

  setUp(() {
    final now = DateTime.now();
    department = Department('id', 'Hairdresser', 'hair cuts', true);
    establishment = Establishment(
        'id',
        'Barber Shop Alphas',
        'alphas@gmail.com',
        'alphas hair',
        'https://image.pns',
        DateTime(now.year, now.month, now.day, 08, 30),
        DateTime(now.year, now.month, now.day, 18, 30));

    reservation = Reservation(
        'id',
        'Cut masculine hair',
        'shaved cut',
        25.00,
        'https://shaved.png',
        DateTime.now(),
        true,
        department,
        establishment,
        DateTime(2022, 6, 20, 12, 30));
  });

  setUpAll(() {
    when(repository.createOrUpdate(any))
        .thenAnswer((realInvocation) async => Right(reservation));

    when(repository.disable(any))
        .thenAnswer((realInvocation) async => const Right(true));
  });

  group('tests to create or update reservation item', () {
    test(
        'should return a reservation from repository when everything is validated',
        () async {
      final result = await usecase.createOrUpdate(reservation);

      expect(result.fold(id, id), isA<Reservation>());
      expect(result.fold(id, id), isA<Item>());
      expect(result.fold((l) => null, (r) => r.name),
          equals('Cut masculine hair'));
    });

    test(
        'Should return a ItemRegistrationError when reservation hour or minute date is before establishment open time',
        () async {
      reservation.reservationDate = DateTime(2022, 06, 16, 07, 30);

      var result = await usecase.createOrUpdate(reservation);

      expect(result.fold(id, id), isA<ItemRegistrationError>());
      expect(result.fold((l) => l.message, (r) => null),
          equals('ReservationDate cannot be before establishment open time'));

      reservation.reservationDate = DateTime(2022, 06, 16, 08, 00);

      result = await usecase.createOrUpdate(reservation);

      expect(result.fold(id, id), isA<ItemRegistrationError>());
      expect(result.fold((l) => l.message, (r) => null),
          equals('ReservationDate cannot be before establishment open time'));

      reservation.reservationDate = DateTime(2022, 06, 16, 08, 29);

      result = await usecase.createOrUpdate(reservation);

      expect(result.fold(id, id), isA<ItemRegistrationError>());
      expect(result.fold((l) => l.message, (r) => null),
          equals('ReservationDate cannot be before establishment open time'));
    });

    test(
        'Should return a ItemRegistrationError when reservation hour or minute date is after establishment close time',
        () async {
      reservation.reservationDate = DateTime(2022, 06, 16, 19, 00);

      var result = await usecase.createOrUpdate(reservation);

      expect(result.fold(id, id), isA<ItemRegistrationError>());
      expect(result.fold((l) => l.message, (r) => null),
          equals('ReservationDate cannot be before establishment close time'));

      reservation.reservationDate = DateTime(2022, 06, 16, 18, 50);

      result = await usecase.createOrUpdate(reservation);

      expect(result.fold(id, id), isA<ItemRegistrationError>());
      expect(result.fold((l) => l.message, (r) => null),
          equals('ReservationDate cannot be before establishment close time'));

      reservation.reservationDate = DateTime(2022, 06, 16, 18, 31);

      result = await usecase.createOrUpdate(reservation);

      expect(result.fold(id, id), isA<ItemRegistrationError>());
      expect(result.fold((l) => l.message, (r) => null),
          equals('ReservationDate cannot be before establishment close time'));
    });
  });

  group('tests to disable a reservation item', () {
    test('should return a true when everything is validated', () async {
      final result = await usecase.disable(reservation);

      expect(result.fold(id, id), isA<bool>());
      expect(result.fold(id, id), equals(true));
    });

    test('should return an ItemRegistrationError when ID is empty', () async {
      reservation.id = '';

      final result = await usecase.disable(reservation);

      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<ItemRegistrationError>());
      expect(result.fold((l) => l.message, (r) => null), equals('Invalid ID'));
    });

    test(
        'should return an ItemRegistrationError when reservation is already disabled',
        () async {
      reservation.enabled = false;

      final result = await usecase.disable(reservation);

      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<ItemRegistrationError>());
    });
  });
}
