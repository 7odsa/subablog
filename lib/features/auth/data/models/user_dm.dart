import 'package:subablog/core/common/entities/user_entity.dart';

class UserDm extends UserEntity {
  UserDm({required super.id, required super.name, required super.email});

  factory UserDm.fromJson(Map<String, dynamic> map) {
    return UserDm(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email '] ?? '',
    );
  }
  UserDm copyWith({String? id, String? name, String? email}) {
    return UserDm(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
