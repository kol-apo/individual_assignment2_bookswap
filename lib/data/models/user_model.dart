class UserModel {
  final String id;
  final String email;
  final String displayName;
  final DateTime createdAt;
  final bool emailVerified;

  UserModel({
    required this.id,
    required this.email,
    required this.displayName,
    required this.createdAt,
    required this.emailVerified,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'createdAt': createdAt.toIso8601String(),
      'emailVerified': emailVerified,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      id: id,
      email: map['email'] ?? '',
      displayName: map['displayName'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
      emailVerified: map['emailVerified'] ?? false,
    );
  }
}
