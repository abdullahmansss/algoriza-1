class UserModel {
  final int id;
  final String token;
  final String name;
  final String email;

  UserModel({
    required this.id,
    required this.token,
    required this.name,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      token: json['api_token'],
      name: json['name'],
      email: json['email'],
    );
  }
}