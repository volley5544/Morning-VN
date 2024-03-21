class DataToken {
  String? firstName;
  String? lastName;

  DataToken({
    required this.firstName,
    required this.lastName,
  });

  factory DataToken.fromJson(Map<String, dynamic> json) {
    return DataToken(
      lastName: json['lastName'] ?? '',
      firstName: json['firstName'] ?? '',
    );
  }
}

class UserToken {
  String token;
  String firebaseToken;
  DataToken? data;

  UserToken({
    required this.token,
    required this.firebaseToken,
    required this.data,
  });

  factory UserToken.fromJson(Map<String, dynamic> json) {
    return UserToken(
        token: json['token'] ?? '',
        firebaseToken: json['firebaseToken'] ?? '',
        data: json[{
          json['lastName'] ?? '',
          json['firstName'] ?? '',
        }]
        // data: json[{'lastName', 'firstName'}],
        );
  }
}
