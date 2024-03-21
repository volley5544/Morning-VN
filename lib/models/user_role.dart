class UserRole {
  List admin;
  List guest;
  String role;
  UserRole({
    required this.admin,
    required this.guest,
    required this.role,
  });

  factory UserRole.fromJson(Map<String, dynamic> json) {
    return UserRole(
      admin: json['/'],
      guest: json['/'],
      role: json['guest'],
    );
  }
}
