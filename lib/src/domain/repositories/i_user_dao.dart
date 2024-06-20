import '../models/user.dart';

abstract interface class IUserDAO {
  Future<List<User>> getUsers();
  Future<bool> insertUser(User post);
  Future<bool> updateUser(User post);
  Future<bool> deleteUser(User post);
}
