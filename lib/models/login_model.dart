class UserModel {
  final String id;
  final String name;
  final String password;
  final String? fcmToken;

  UserModel({
    required this.id,
    required this.name,
    required this.password,
    this.fcmToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'password': password,
      'fcm_token': fcmToken,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      password: json['password'],
      fcmToken: json['fcm_token'],
    );
  }
}
