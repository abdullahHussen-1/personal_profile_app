
class UserModel {
  final int id;
  final String fullName;
  final String email;
  final String phone;
  final String bio;
  final String? avatarUrl;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.bio,
    this.avatarUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id:        json['id'] as int,
        fullName:  json['fullName'] as String,
        email:     json['email'] as String,
        phone:     json['phone'] as String? ?? '',
        bio:       json['bio'] as String? ?? '',
        avatarUrl: json['avatarUrl'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'email': email,
        'phone': phone,
        'bio': bio,
        'avatarUrl': avatarUrl,
      };
}

class AuthResponse {
  final String token;
  final UserModel user;

  const AuthResponse({required this.token, required this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        token: json['token'] as String,
        user:  UserModel.fromJson(json['user'] as Map<String, dynamic>),
      );
}
