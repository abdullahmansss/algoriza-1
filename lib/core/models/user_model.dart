class UserModel {
  final int id;
  final String token;
  final String name;
  final String email;
  final String image;

  UserModel({
    required this.id,
    required this.token,
    required this.name,
    required this.email,
    required this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      token: json['api_token'],
      name: json['name'],
      email: json['email'],
      image: json['image'],
    );
  }
}