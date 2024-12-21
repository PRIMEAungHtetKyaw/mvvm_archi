// Mocks generated by Mockito 5.4.4 from annotations
// in todo_mvvm/test/mocks.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:todo_mvvm/domain/entities/item.dart' as _i6;
import 'package:todo_mvvm/domain/entities/user.dart' as _i4;
import 'package:todo_mvvm/domain/repositories/auth_repository.dart' as _i2;
import 'package:todo_mvvm/domain/repositories/item_repository.dart' as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [AuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthRepository extends _i1.Mock implements _i2.AuthRepository {
  MockAuthRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i4.User?> login(
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #login,
          [
            email,
            password,
          ],
        ),
        returnValue: _i3.Future<_i4.User?>.value(),
      ) as _i3.Future<_i4.User?>);

  @override
  _i3.Future<void> register(
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #register,
          [
            email,
            password,
          ],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> logout() => (super.noSuchMethod(
        Invocation.method(
          #logout,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<_i4.User?> getCurrentUser() => (super.noSuchMethod(
        Invocation.method(
          #getCurrentUser,
          [],
        ),
        returnValue: _i3.Future<_i4.User?>.value(),
      ) as _i3.Future<_i4.User?>);
}

/// A class which mocks [ItemRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockItemRepository extends _i1.Mock implements _i5.ItemRepository {
  MockItemRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i6.Item>> fetchItems() => (super.noSuchMethod(
        Invocation.method(
          #fetchItems,
          [],
        ),
        returnValue: _i3.Future<List<_i6.Item>>.value(<_i6.Item>[]),
      ) as _i3.Future<List<_i6.Item>>);

  @override
  _i3.Future<void> addItem(_i6.Item? item) => (super.noSuchMethod(
        Invocation.method(
          #addItem,
          [item],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> deleteItem(String? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteItem,
          [id],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> updateItem(_i6.Item? item) => (super.noSuchMethod(
        Invocation.method(
          #updateItem,
          [item],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}
