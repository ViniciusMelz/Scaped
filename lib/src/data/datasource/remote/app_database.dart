import 'package:scaped/src/data/datasource/remote/dao/user_dao.dart';

import 'dao/post_dao.dart';
import 'db.dart';

class AppDatabase {
  AppDatabase() {
    DB.init();
  }
  PostDAO? _postDAO;

  PostDAO get postDao {
    return _postDAO ??= PostDAO();
  }

  UserDAO? _userDAO;
  UserDAO get userDao {
    return _userDAO ??= UserDAO();
  }
}
