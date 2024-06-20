class User {
  String uuid;
  String name;
  String lastName;
  String avatar;
  bool isAdmin;

  User({
    required this.uuid,
    required this.name,
    required this.lastName,
    required this.avatar,
    this.isAdmin = false,
  });

  factory User.fromMap(Map<String, dynamic> e) {
    return User(
      uuid: e['id'],
      name: e['name'],
      lastName: e['last_name'],
      avatar: e['avatar'] ?? '',
      isAdmin: e['is_admin'] ?? false,
    );
  }

  factory User.empty() {
    return User(uuid: '', name: '', lastName: '', avatar: '');
  }
}
