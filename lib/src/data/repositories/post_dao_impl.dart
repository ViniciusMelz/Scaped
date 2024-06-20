import 'package:scaped/src/data/datasource/remote/app_database.dart';
import 'package:scaped/src/domain/models/post.dart';
import 'package:scaped/src/domain/repositories/i_post_dao.dart';

class PostDAOImpl implements IPostDAO {
  final AppDatabase _appDataBase;

  PostDAOImpl(this._appDataBase);

  @override
  Future<bool> deletePost(Post post) {
    return _appDataBase.postDao.delete(post);
  }

  @override
  Future<bool> insertPost(Post post) {
    return _appDataBase.postDao.insert(post);
  }

  @override
  Future<bool> updatePost(Post post) {
    return _appDataBase.postDao.update(post);
  }

  @override
  Future<List<Post>> getPosts() {
    return _appDataBase.postDao.getAll();
  }

  @override
  Future<List<Post>> getMyPosts() {
    return _appDataBase.postDao.getMyPosts();
  }
}
