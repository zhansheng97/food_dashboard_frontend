class UserModel {
  int id;
  String username;
  String email;
  List<String> roles;
  String accessToken;
  String tokenType;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.roles,
    required this.accessToken,
    required this.tokenType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      roles: json['roles'].cast<String>(),
      accessToken: json['accessToken'],
      tokenType: json['tokenType'],
    );
  }
}
