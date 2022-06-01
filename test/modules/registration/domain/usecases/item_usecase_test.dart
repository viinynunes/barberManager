import 'package:barbar_manager/modules/registration/domain/entities/department.dart';
import 'package:barbar_manager/modules/registration/domain/entities/item.dart';
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

  setUpAll(() {
    final item = Item('id', 'shampoo', 'shampoo for man', 20.00,
        'https://google.images.com/shampoo', true, department);

    when(repository.createOrUpdate(any))
        .thenAnswer((realInvocation) async => Right(item));

    when(repository.disable(any))
        .thenAnswer((realInvocation) async => const Right(true));
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
          true,
          department));

      expect(result.fold(id, id), isA<Item>());
      expect(result.fold((l) => null, (r) => r.name), equals('shampoo'));
    });

    test('should return a ItemRegistrationError when name is invalid',
        () async {
      var result = await usecase.createOrUpdate(Item(
          'id',
          '',
          'water to wash your hair',
          5.00,
          'https://google.images.com/shampoo',
          true,
          department));

      expect(result.fold(id, id), isA<ItemRegistrationError>());

      result = await usecase.createOrUpdate(Item(
          'id',
          '2',
          'water to wash your hair',
          5.00,
          'https://google.images.com/shampoo',
          true,
          department));

      expect(result.fold(id, id), isA<ItemRegistrationError>());
    });

    test('should return a ItemRegistrationError when description is invalid',
        () async {
      final result = await usecase.createOrUpdate(Item('id', 'water', '', 5.00,
          'https://google.images.com/shampoo', true, department));

      expect(result.fold(id, id), isA<ItemRegistrationError>());
    });

    test('should return a ItemRegistrationError when price is invalid',
        () async {
      var result = await usecase.createOrUpdate(Item(
          'id',
          'water',
          'water to wash your hair',
          -5.00,
          'https://google.images.com/shampoo',
          true,
          department));

      expect(result.fold(id, id), isA<ItemRegistrationError>());
    });

    test('should return a ItemRegistrationError when image url is invalid',
        () async {
      var result = await usecase.createOrUpdate(Item('id', 'water',
          'water to wash your hair', 5.00, '', true, department));

      expect(result.fold(id, id), isA<ItemRegistrationError>());
    });

    test('should return a ItemRegistrationError when Department is invalid',
        () async {
      final testDep = Department('', 'Shop', 'Shoping something', true);
      var result = await usecase.createOrUpdate(Item(
          'id', 'water', 'water to wash your hair', 5.00, '', true, testDep));

      expect(result.fold(id, id), isA<ItemRegistrationError>());

      final testDepDisable =
          Department('aaaaa', 'Shop', 'Shoping something', false);

      result = await usecase.createOrUpdate(Item('id', 'water',
          'water to wash your hair', 5.00, '', true, testDepDisable));

      expect(result.fold(id, id), isA<ItemRegistrationError>());
    });
  });
}
