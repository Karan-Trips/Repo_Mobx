import '../../data/userModel/user_model.dart';

abstract class IServicesRepo {
  Future<UserData> fetchUsers();
  Future<dynamic> createUser(UserSave userSave);
  Future<void> deleteUser(int id);
  Future<dynamic> updateUser(int id, Map<String, dynamic> user);
  Future<dynamic> loginUser(Map<String, dynamic> userSave);
}
