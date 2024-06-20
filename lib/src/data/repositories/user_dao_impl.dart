import 'package:scaped/src/data/datasource/remote/app_database.dart';
import 'package:scaped/src/domain/models/user.dart';
import 'package:scaped/src/domain/repositories/i_user_dao.dart';

class UserDAOImpl implements IUserDAO {
  final AppDatabase _appDataBase;

  UserDAOImpl(this._appDataBase);

  @override
  Future<bool> deleteUser(User user) {
    return _appDataBase.userDao.delete(user);
  }

  @override
  Future<List<User>> getUsers() {
    return _appDataBase.userDao.getAll();
  }

  @override
  Future<bool> insertUser(User user) {
    return _appDataBase.userDao.insert(user);
  }

  @override
  Future<bool> updateUser(User user) {
    return _appDataBase.userDao.update(user);
  }
}
