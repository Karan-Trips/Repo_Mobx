// ignore_for_file: library_private_types_in_public_api

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../ExceptionModel/exception_model.dart';
import '../userModel/user_model.dart';
import 'package:dio/dio.dart';
import '../Api/api_services.dart';
import '../Repo/services_repo.dart'; // Import ServicesRepo

part 'user_mobx.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  final ServicesRepo servicesRepo = ServicesRepo(ApiService(Dio()));
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

  @action
  Future<void> checkConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    connectionStatus = ObservableFuture(Future.value(
        connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile));
  }

  Future<void> _handleApiCall(Function apiCall) async {
    isLoading = true;
    errorMessage = '';
    try {
      await checkConnection();
      if (connectionStatus?.value == false) {
        showToast("No internet connection!");
        throw Exception('No internet connection');
      }
      await apiCall();
    } on ApiException catch (e) {
      errorMessage = 'Error: ${e.statusCode} ${e.message}';
      showToast(errorMessage);
      debugPrint('ApiException: $e');
    } on DioException catch (e) {
      exceptions.handleDioError(e);
      errorMessage =
          '${exceptions.errorMessage} \n (${e.response?.statusCode})';
      showToast(errorMessage);
    } catch (error) {
      errorMessage = 'An error occurred: $error';
      showToast(errorMessage);
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> fetchUsers() async {
    await _handleApiCall(() async {
      final data = await servicesRepo.fetchUsers();
      userData = data;
    });
  }

  @action
  Future<void> createUser(UserSave userSave) async {
    await _handleApiCall(() async {
      await servicesRepo.createUser(userSave);
    });
  }

  @action
  Future<void> loginUser(Map<String, dynamic> userSave) async {
    await _handleApiCall(() async {
      await servicesRepo.loginUser(userSave);
    });
  }

  @action
  Future<void> updateUser(int id, Map<String, dynamic> user) async {
    await _handleApiCall(() async {
      await servicesRepo.updateUser(id, user);
    });
  }

  @action
  Future<void> deleteUser(int id) async {
    await _handleApiCall(() async {
      await servicesRepo.deleteUser(id);
    });
  }
}

final userStore = UserStore();
