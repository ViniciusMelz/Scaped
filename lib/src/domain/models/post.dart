import 'user.dart';

class Post {
  int id;
  DateTime createdAt;
  DateTime? updatedAt;
  String title;
  String issue;
  User author;

  Post({
    required this.id,
    required this.title,
    required this.issue,
    required this.author,
    required this.createdAt,
    this.updatedAt,
  });

  factory Post.fromMap(Map<String, dynamic> e) {
    return Post(
      id: e['id'],
      createdAt: DateTime.tryParse(e['created_at']) ?? DateTime(1899, 01, 01),
      updatedAt: DateTime.tryParse(e['created_at']),
      title: e['title'],
      issue: e['issue'],
      author: User.fromMap(e['profiles']),
    );
  }

  factory Post.empty() {
    return Post(id: -1, title: '', issue: '', author: User.empty(), createdAt: DateTime.now());
  }
}
