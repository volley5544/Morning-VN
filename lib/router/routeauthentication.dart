import 'package:mobile_application_srisawad/models/user_role.dart';

class RouteAuthentication {
  static bool permission(String role, String path) {
    UserRole userRole = UserRole(
        admin: ['main-page', '/'], guest: ['main-page', '/'], role: role);
    if (userRole.role.contains(path)) return true;
    return false;
  }
}
