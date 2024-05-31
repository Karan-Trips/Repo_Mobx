// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';

part 'form_mobx.g.dart';

class FormStore = _FormStore with _$FormStore;

abstract class _FormStore with Store {
  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  String confirmPassword = '';

  @observable
  bool passwordVisible = false;

  @observable
  bool confirmPasswordVisible = false;

  @action
  void setEmail(String value) {
    email = value;
  }

  @action
  void setPassword(String value) {
    password = value;
  }

  @action
  void setConfirmPassword(String value) {
    confirmPassword = value;
  }

  @action
  void togglePasswordVisibility() {
    passwordVisible = !passwordVisible;
  }

  @action
  void toggleConfirmPasswordVisibility() {
    confirmPasswordVisible = !confirmPasswordVisible;
  }

  @action
  void clearEmail() {
    email = '';
  }
}
final formStore = FormStore();