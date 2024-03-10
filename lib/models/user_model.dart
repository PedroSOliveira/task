class UserStorage {
  final String id;
  final String name;
  late final String email;
  late final String photo;

  UserStorage({
    required this.id,
    required this.name,
    required this.email,
    required this.photo,
  });

  factory UserStorage.fromJson(Map<String, dynamic> json) {
    return UserStorage(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      photo: json['photo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photo': photo,
    };
  }
}
