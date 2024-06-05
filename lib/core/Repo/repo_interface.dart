import '../../data/userModel/user_model.dart';

abstract class IServicesRepo {
  Future<void> fetchUsers();
  Future<void> createUser(UserSave userSave);
  Future<void> deleteUser(int id);
  Future<void> updateUser(int id, Map<String, dynamic> user);
  Future<void> loginUser(Map<String, dynamic> userSave);
}
