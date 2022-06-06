import 'package:barbar_manager/modules/registration/domain/entities/department.dart';
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
  final department = Department('id', 'Hairdresser', 'hair cuts', true);
  final reservation = Reservation(
      'id',
      'Cut masculine hair',
      'shaved cut',
      25.00,
      'https://shaved.png',
      DateTime.now(),
      true,
      department,
      DateTime(2022, 06, 10, 15, 30));

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
        'should return a ItemRegistrationError when registration date is missing hour and/or minute',
        () async {
      var result = await usecase.createOrUpdate(
        Reservation(
          'id',
          'Woman Hair',
          'V cut',
          65,
          'https://womanhair.png',
          DateTime.now(),
          true,
          department,
          DateTime(2022, 10, 5),
        ),
      );

      expect(result.fold(id, id), isA<ItemRegistrationError>());

      result = await usecase.createOrUpdate(
        Reservation(
          'id',
          'Woman Hair',
          'V cut',
          65,
          'https://womanhair.png',
          DateTime.now(),
          true,
          department,
          DateTime(2022, 10, 5, 0),
        ),
      );

      expect(result.fold(id, id), isA<ItemRegistrationError>());

      result = await usecase.createOrUpdate(
        Reservation(
          'id',
          'Woman Hair',
          'V cut',
          65,
          'https://womanhair.png',
          DateTime.now(),
          true,
          department,
          DateTime(2022, 10, 5, 0, 30),
        ),
      );

      expect(result.fold(id, id), isA<ItemRegistrationError>());
    });
  });

  group('tests to disable a reservation item', () {
    test('should return a true when everything is validated', () async {
      final result = await usecase.disable(reservation);

      expect(result.fold(id, id), isA<bool>());
      expect(result.fold(id, id), equals(true));
    });

    test('should return an ItemRegistrationError when ID is empty', () async {
      final result = await usecase.disable(Reservation(
          '',
          'Shampoo',
          'Shampoo for man',
          5,
          'https://google.images.com/shampoo.png',
          DateTime.now(),
          true,
          department,
          DateTime.now()));

      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<ItemRegistrationError>());
    });

    test('should return an ItemRegistrationError when item is already disabled',
        () async {
      final result = await usecase.disable(Reservation(
          'aaaa',
          'Shampoo',
          'Shampoo for man',
          5,
          'https://google.images.com/shampoo.png',
          DateTime.now(),
          false,
          department,
          DateTime.now()));

      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<ItemRegistrationError>());
    });
  });
}
