// Mocks generated by Mockito 5.2.0 from annotations
// in barbar_manager/test/modules/registration/usecases/establishment_usecase_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:barbar_manager/modules/registration/domain/entities/establishment.dart'
    as _i6;
import 'package:barbar_manager/modules/registration/domain/errors/registration_errors.dart'
    as _i5;
import 'package:barbar_manager/modules/registration/domain/repositories/establishment_repository.dart'
    as _i3;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [EstablishmentRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockEstablishmentRepository extends _i1.Mock
    implements _i3.EstablishmentRepository {
  MockEstablishmentRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.RegistrationErrors, _i6.Establishment>>
      createOrUpdate(_i6.Establishment? establishment) => (super.noSuchMethod(
          Invocation.method(#createOrUpdate, [establishment]),
          returnValue: Future<
                  _i2.Either<_i5.RegistrationErrors, _i6.Establishment>>.value(
              _FakeEither_0<_i5.RegistrationErrors, _i6.Establishment>())) as _i4
          .Future<_i2.Either<_i5.RegistrationErrors, _i6.Establishment>>);
}
