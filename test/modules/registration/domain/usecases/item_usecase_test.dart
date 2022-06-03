import 'package:barbar_manager/modules/registration/domain/entities/department.dart';
import 'package:barbar_manager/modules/registration/domain/entities/item.dart';
import 'package:barbar_manager/modules/registration/domain/entities/reservation.dart';
import 'package:barbar_manager/modules/registration/domain/errors/registration_errors.dart';
import 'package:barbar_manager/modules/registration/domain/usecases/impl/item_usecase_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../repositories/repositories_mock.mocks.dart';

main() {
  final repository = MockItemRepository();
  final usecase = ItemUsecaseImpl(repository);
  final department = Department('id', 'Shop', 'All products', true);
  final reservation = Reservation(
      'ID',
      'Wash masculine hair',
      'Wash masculine hair with shampoo',
      15.00,
      'https://google.images.com/shampoo.png',
      DateTime.now(),
      true,
      department,
      DateTime(2022, 06, 1, 15, 30));

  setUpAll(() {
    final item = Item('id', 'shampoo', 'shampoo for man', 20.00,
        'https://google.images.com/shampoo', DateTime.now(), true, department);

    when(repository.createOrUpdate(any))
        .thenAnswer((realInvocation) async => Right(item));

    when(repository.disable(any))
        .thenAnswer((realInvocation) async => const Right(true));

    when(repository.createOrUpdate(reservation))
        .thenAnswer((realInvocation) async => Right(reservation));
  });

  group('tests to create or update item usecase', () {
    test('should return an item from repository when everything is validated',
        () async {
      final result = await usecase.createOrUpdate(Item(
          'id',
          'water',
          'water to wash your hair',
          5.00,
          'https://google.images.com/shampoo',
          DateTime.now(),
          true,
          department));

      expect(result.fold(id, id), isA<Item>());
      expect(result.fold((l) => null, (r) => r.name), equals('shampoo'));
    });

    test('should return an ItemRegistrationError when name is invalid',
        () async {
      var result = await usecase.createOrUpdate(Item(
          'id',
          '',
          'water to wash your hair',
          5.00,
          'https://google.images.com/shampoo',
          DateTime.now(),
          true,
          department));

      expect(result.fold(id, id), isA<ItemRegistrationError>());

      result = await usecase.createOrUpdate(Item(
          'id',
          '2',
          'water to wash your hair',
          5.00,
          'https://google.images.com/shampoo',
          DateTime.now(),
          true,
          department));

      expect(result.fold(id, id), isA<ItemRegistrationError>());
    });

    test('should return an ItemRegistrationError when description is invalid',
        () async {
      final result = await usecase.createOrUpdate(Item(
          'id',
          'water',
          '',
          5.00,
          'https://google.images.com/shampoo',
          DateTime.now(),
          true,
          department));

      expect(result.fold(id, id), isA<ItemRegistrationError>());
    });

    test('should return an ItemRegistrationError when price is invalid',
        () async {
      var result = await usecase.createOrUpdate(Item(
          'id',
          'water',
          'water to wash your hair',
          -5.00,
          'https://google.images.com/shampoo',
          DateTime.now(),
          true,
          department));

      expect(result.fold(id, id), isA<ItemRegistrationError>());
    });

    test('should return an ItemRegistrationError when image url is invalid',
        () async {
      var result = await usecase.createOrUpdate(Item(
          'id',
          'water',
          'water to wash your hair',
          5.00,
          '',
          DateTime.now(),
          true,
          department));

      expect(result.fold(id, id), isA<ItemRegistrationError>());
    });

    test('should return an ItemRegistrationError when Department is invalid',
        () async {
      final testDep = Department('', 'Shop', 'Shoping something', true);
      var result = await usecase.createOrUpdate(Item('id', 'water',
          'water to wash your hair', 5.00, '', DateTime.now(), true, testDep));

      expect(result.fold(id, id), isA<ItemRegistrationError>());

      final testDepDisable =
          Department('aaaaa', 'Shop', 'Shoping something', false);

      result = await usecase.createOrUpdate(Item(
          'id',
          'water',
          'water to wash your hair',
          5.00,
          '',
          DateTime.now(),
          true,
          testDepDisable));

      expect(result.fold(id, id), isA<ItemRegistrationError>());
    });

    test(
        'should return an ItemRegistrationError when registration Date is has a negative number',
        () async {
      var result = await usecase.createOrUpdate(Item(
          'id',
          'water',
          'water to wash your hair',
          5.00,
          '',
          DateTime(-2022, 10, 2),
          true,
          department));

      expect(result.fold(id, id), isA<ItemRegistrationError>());

      result = await usecase.createOrUpdate(Item(
          'id',
          'water',
          'water to wash your hair',
          5.00,
          '',
          DateTime(2022, -10, 2),
          true,
          department));

      expect(result.fold(id, id), isA<ItemRegistrationError>());

      result = await usecase.createOrUpdate(Item(
          'id',
          'water',
          'water to wash your hair',
          5.00,
          '',
          DateTime(2022, 10, 2),
          true,
          department));

      expect(result.fold(id, id), isA<ItemRegistrationError>());
    });
  });

  group('tests to disable item usecase', () {
    final testDep = Department('aaaa', 'Shop', 'Shop products', true);

    test('should disable and item when everything is correct', () async {
      final result = await usecase.disable(Item(
          'id',
          'shampoo',
          'shampoo for man',
          5,
          'https://google.images.com/shampoo.png',
          DateTime.now(),
          true,
          testDep));

      expect(result.fold(id, id), isA<bool>());
      expect(result.fold(id, id), equals(true));
    });

    test('should return an ItemRegistrationError when ID is empty', () async {
      final result = await usecase.disable(Item(
          '',
          'Shampoo',
          'Shampoo for man',
          5,
          'https://google.images.com/shampoo.png',
          DateTime.now(),
          true,
          testDep));

      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<ItemRegistrationError>());
    });

    test('should return an ItemRegistrationError when item is already disabled',
        () async {
      final result = await usecase.disable(Item(
          'aaaa',
          'Shampoo',
          'Shampoo for man',
          5,
          'https://google.images.com/shampoo.png',
          DateTime.now(),
          false,
          testDep));

      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<ItemRegistrationError>());
    });
  });
}
