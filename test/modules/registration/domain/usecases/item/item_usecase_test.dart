import 'package:barbar_manager/modules/registration/domain/entities/department.dart';
import 'package:barbar_manager/modules/registration/domain/entities/establishment.dart';
import 'package:barbar_manager/modules/registration/domain/entities/item.dart';
import 'package:barbar_manager/modules/registration/domain/entities/reservation.dart';
import 'package:barbar_manager/modules/registration/domain/errors/registration_errors.dart';
import 'package:barbar_manager/modules/registration/domain/usecases/impl/item_usecase_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../repositories/repositories_mock.mocks.dart';

main() {
  final repository = MockItemRepository();
  final usecase = ItemUsecaseImpl(repository);
  final department = Department('id', 'Shop', 'All products', true);
  late Establishment establishment;
  late Reservation reservation;
  late Item item;

  setUp(() {
    establishment = Establishment(
        'id',
        'Barber Shop Alphas',
        'alphas@gmail.com',
        'alphas hair',
        'https://image.png',
        DateTime.now(),
        DateTime.now());

    reservation = Reservation(
        'ID',
        'Wash masculine hair',
        'Wash masculine hair with shampoo',
        15.00,
        'https://google.images.com/shampoo.png',
        DateTime.now(),
        true,
        department,
        establishment,
        DateTime(2022, 06, 1, 15, 30));

    item = Item(
        'id',
        'shampoo',
        'shampoo for man',
        20.00,
        'https://google.images.com/shampoo',
        DateTime.now(),
        true,
        department,
        establishment);

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
      final result = await usecase.createOrUpdate(item);

      expect(result.fold(id, id), isA<Item>());
      expect(result.fold((l) => null, (r) => r.name), equals('shampoo'));
    });

    test('should return an ItemRegistrationError when name is invalid',
        () async {
      item.name = '';

      var result = await usecase.createOrUpdate(item);

      expect(result.fold(id, id), isA<ItemRegistrationError>());

      item.name = '2';

      result = await usecase.createOrUpdate(item);

      expect(result.fold(id, id), isA<ItemRegistrationError>());
    });

    test('should return an ItemRegistrationError when description is invalid',
        () async {
      item.description = '';

      final result = await usecase.createOrUpdate(item);

      expect(result.fold(id, id), isA<ItemRegistrationError>());
    });

    test('should return an ItemRegistrationError when price is invalid',
        () async {
      item.price = -5.00;

      var result = await usecase.createOrUpdate(item);

      expect(result.fold(id, id), isA<ItemRegistrationError>());
    });

    test('should return an ItemRegistrationError when image url is invalid',
        () async {
      item.imgUrl = '';

      var result = await usecase.createOrUpdate(item);

      expect(result.fold(id, id), isA<ItemRegistrationError>());
    });

    test('should return an ItemRegistrationError when Department is invalid',
        () async {
      department.id = '';

      var result = await usecase.createOrUpdate(item);

      expect(result.fold(id, id), isA<ItemRegistrationError>());

      department.id = 'aaaa';
      department.enabled = false;

      result = await usecase.createOrUpdate(item);

      expect(result.fold(id, id), isA<ItemRegistrationError>());
    });
  });

  group('tests to disable item usecase', () {
    test('should disable and item when everything is correct', () async {
      final result = await usecase.disable(item);

      expect(result.fold(id, id), isA<bool>());
      expect(result.fold(id, id), equals(true));
    });

    test('should return an ItemRegistrationError when ID is empty', () async {
      item.id = '';

      final result = await usecase.disable(item);

      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<ItemRegistrationError>());
    });

    test('should return an ItemRegistrationError when item is already disabled',
        () async {
      item.enabled = false;

      final result = await usecase.disable(item);

      expect(result, isA<Left>());
      expect(result.fold(id, id), isA<ItemRegistrationError>());
    });
  });
}
