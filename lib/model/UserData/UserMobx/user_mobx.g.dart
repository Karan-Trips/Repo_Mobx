// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on _UserStore, Store {
  late final _$isLoadingAtom =
      Atom(name: '_UserStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_UserStore.errorMessage', context: context);

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$userDataAtom =
      Atom(name: '_UserStore.userData', context: context);

  @override
  UserData? get userData {
    _$userDataAtom.reportRead();
    return super.userData;
  }

  @override
  set userData(UserData? value) {
    _$userDataAtom.reportWrite(value, super.userData, () {
      super.userData = value;
    });
  }

  late final _$connectionStatusAtom =
      Atom(name: '_UserStore.connectionStatus', context: context);

  @override
  ObservableFuture<bool>? get connectionStatus {
    _$connectionStatusAtom.reportRead();
    return super.connectionStatus;
  }

  @override
  set connectionStatus(ObservableFuture<bool>? value) {
    _$connectionStatusAtom.reportWrite(value, super.connectionStatus, () {
      super.connectionStatus = value;
    });
  }

  late final _$selectedUserAtom =
      Atom(name: '_UserStore.selectedUser', context: context);

  @override
  Datum? get selectedUser {
    _$selectedUserAtom.reportRead();
    return super.selectedUser;
  }

  @override
  set selectedUser(Datum? value) {
    _$selectedUserAtom.reportWrite(value, super.selectedUser, () {
      super.selectedUser = value;
    });
  }

  late final _$checkConnectionAsyncAction =
      AsyncAction('_UserStore.checkConnection', context: context);

  @override
  Future<void> checkConnection() {
    return _$checkConnectionAsyncAction.run(() => super.checkConnection());
  }

  late final _$fetchUsersAsyncAction =
      AsyncAction('_UserStore.fetchUsers', context: context);

  @override
  Future<void> fetchUsers() {
    return _$fetchUsersAsyncAction.run(() => super.fetchUsers());
  }

  late final _$createUserAsyncAction =
      AsyncAction('_UserStore.createUser', context: context);

  @override
  Future<void> createUser(UserSave userSave) {
    return _$createUserAsyncAction.run(() => super.createUser(userSave));
  }

  late final _$loginUserAsyncAction =
      AsyncAction('_UserStore.loginUser', context: context);

  @override
  Future<void> loginUser(Map<String, dynamic> userSave) {
    return _$loginUserAsyncAction.run(() => super.loginUser(userSave));
  }

  late final _$updateUserAsyncAction =
      AsyncAction('_UserStore.updateUser', context: context);

  @override
  Future<void> updateUser(int id, Map<String, dynamic> user) {
    return _$updateUserAsyncAction.run(() => super.updateUser(id, user));
  }

  late final _$deleteUserAsyncAction =
      AsyncAction('_UserStore.deleteUser', context: context);

  @override
  Future<void> deleteUser(int id) {
    return _$deleteUserAsyncAction.run(() => super.deleteUser(id));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
errorMessage: ${errorMessage},
userData: ${userData},
connectionStatus: ${connectionStatus},
selectedUser: ${selectedUser}
    ''';
  }
}
