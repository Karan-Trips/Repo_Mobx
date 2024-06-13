import 'package:flutter/material.dart';
import 'package:apistsk/core/Repo/repo_interface.dart';
import '../Exception/exception_model.dart';
import '../Api/api_services.dart';
import '../../data/userModel/user_model.dart';

class ServicesRepo implements IServicesRepo {
  final ApiService apiService;

  ServicesRepo(
    this.apiService,
  );

  @override
  Future<UserData> fetchUsers() async {
    try {
      final response = await apiService.fetchUsers();
      if (response.response.statusCode == 200) {
        showToast('Data loaded successfully ${response.response.statusCode}');

        return response.data;
      } else {
        throw ApiException(
            response.response.statusCode, response.response.statusMessage);
      }
    } catch (e) {
      debugPrint('Error fetching users: $e');
      rethrow;
    }
  }

  @override
  Future<dynamic> createUser(UserSave user) async {
    try {
      final response = await apiService.createUser(user);
      if (response.response.statusCode == 200) {
        showToast(
            "Account Created Successfully ${response.response.statusCode}");
        final token = response.data['token'];
        // final userId = response.data['id'];
        debugPrint(token.toString());
        
        return response.data;
      } else {
        throw ApiException(
            response.response.statusCode, response.response.statusMessage);
      }
    } catch (e) {
      debugPrint('Error creating user: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteUser(int id) async {
    try {
      final res = await apiService.deleteUser(id);
      if (res.response.statusCode == 204) {
        debugPrint('Data deleted at $id');
        showToast("User $id Deleted  ${res.response.statusCode}");
        await fetchUsers();
      } else {
        throw ApiException(res.response.statusCode, res.response.statusMessage);
      }
    } catch (e) {
      debugPrint('Error deleting user: $e');
      rethrow;
    }
  }

  @override
  Future<dynamic> updateUser(int id, Map<String, dynamic> user) async {
    try {
      final response = await apiService.updateUser(id, user);
      if (response.response.statusCode == 200) {
        showToast("Data Updated Successfully ${response.response.statusCode}");
        return response.data;
      } else {
        throw ApiException(
            response.response.statusCode, response.response.statusMessage);
      }
    } catch (e) {
      debugPrint('Error updating user: $e');
      rethrow;
    }
  }

  @override
  Future<dynamic> loginUser(Map<String, dynamic> user) async {
    try {
      final response = await apiService.loginUser(user);
      if (response.response.statusCode == 200) {
        showToast("Logged in Successfully ${response.response.statusCode}");
        return response.data;
      } else {
        throw ApiException(
            response.response.statusCode, response.response.statusMessage);
      }
    } catch (e) {
      debugPrint('Error logging in user: $e');
      rethrow;
    }
  }
}
