// ignore_for_file: library_private_types_in_public_api

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../ExceptionModel/exception_model.dart';
import '../userModel/user_model.dart';
import 'package:dio/dio.dart';
import 'api_services.dart';

part 'user_mobx.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  final ApiService apiService = ApiService(Dio());
  final Exceptions exceptions = Exceptions();

  @observable
  bool isLoading = false;

  @observable
  String errorMessage = '';

  @observable
  UserData? userData;

  @observable
  ObservableFuture<bool>? connectionStatus;

  @observable
  Datum? selectedUser;

  Future<void> checkConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    connectionStatus = ObservableFuture(Future.value(
        connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile));
  }

  @action
  Future<void> fetchUsers() async {
    isLoading = true;
    errorMessage = '';
    try {
      await checkConnection();
      if (connectionStatus?.value == false) {
        showToast("No internet connection!");
        throw Exception('No internet connection');
      }
      final response = await apiService.fetchUsers();
      if (response.response.statusCode == 200) {
        userData = response.data;
        showToast('Data loaded successfully ${response.response.statusCode}');
        debugPrint('status code ${response.response.statusCode}');
      }
    } on DioException catch (e) {
      exceptions.handleDioError(e);
      errorMessage =
          '${exceptions.errorMessage} \n (${e.response?.statusCode})';
    } catch (error) {
      errorMessage = 'Failed to load users: $error';
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> createUser(UserSave userSave) async {
    isLoading = true;
    errorMessage = '';
    try {
      await checkConnection();
      if (connectionStatus?.value == false) {
        showToast("No internet connection!");
        throw Exception('No internet connection');
      }
      final response = await apiService.createUser(userSave);

      if (response.response.statusCode == 200) {
        showToast(
            "Account Created Successfully ${response.response.statusCode}");
      } else {
        errorMessage = 'Failed to create user: ${response.response.statusCode}';
        showToast(errorMessage);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        errorMessage =
            'Failed to create user: ${e.response?.statusCode} ${e.response?.statusMessage}';
        showToast(errorMessage);
      } else {
        errorMessage = 'Failed to create user: ${e.message}';
        showToast(errorMessage);
      }
      exceptions.handleDioError(e);
      errorMessage = exceptions.errorMessage;
    } catch (error) {
      errorMessage = 'Failed to create user: $error';
      showToast(errorMessage);
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> loginUser(UserSave userSave) async {
    isLoading = true;
    errorMessage = '';
    try {
      await checkConnection();
      
      if (connectionStatus?.value == false) {
        showToast("No internet connection!");
        throw Exception('No internet connection');
      }
      var response = await apiService.loginUser(userSave);
      if (response.response.statusCode == 200) {
        debugPrint('Status code 200 Logged in');
        showToast("Logged in Successfully ${response.response.statusCode}");
      } else {
        errorMessage = 'Failed to create user: ${response.response.statusCode}';
        showToast(errorMessage);
      }
    } on DioException catch (e) {
      errorMessage = 'Failed to login user: ${e.message}';
      if (e.response != null) {
        debugPrint('Error response: ${e.response?.data}');
      }
    } catch (error) {
      errorMessage = 'Failed to login user: $error';
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> updateUser(int id, SaveJob user) async {
    isLoading = true;
    errorMessage = '';
    try {
      await checkConnection();
      if (connectionStatus?.value == false) {
        showToast("No internet connection!");
        throw Exception('No internet connection');
      }
      final response = await apiService.updateUser(id, user);
      if (response.response.statusCode == 200) {
        selectedUser = response.data;
        debugPrint('!!! Data Updated !!!');
        showToast("Data Updated Successfully  ${response.response.statusCode}");
        fetchUsers();
      } else {
        errorMessage = 'Failed to create user: ${response.response.statusCode}';
        showToast(errorMessage);
      }
    } on DioException catch (e) {
      exceptions.handleDioError(e);
      errorMessage = exceptions.errorMessage;
    } catch (error) {
      errorMessage = 'Failed to update user: $error';
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> deleteUser(int id) async {
    isLoading = true;
    errorMessage = '';
    try {
      await checkConnection();
      if (connectionStatus?.value == false) {
        showToast("No internet connection!");
        throw Exception('No internet connection');
      }

      var res = await apiService.deleteUser(id);
      if (res.response.statusCode == 204) {
        debugPrint('Data deleted at $id');
        showToast("User $id Deleted  ${res.response.statusCode}");
        fetchUsers();
      } else {
        errorMessage = 'Failed to create user: ${res.response.statusCode}';
        showToast(errorMessage);
      }
    } on DioException catch (e) {
      exceptions.handleDioError(e);
      errorMessage = exceptions.errorMessage;
    } catch (error) {
      errorMessage = 'Failed to delete user: $error';
    } finally {
      isLoading = false;
    }
  }
}

final userStore = UserStore();
