enum UserRole {
  driver,
  parent,
  admin,
  unknown,
}

extension UserRoleExtension on UserRole {
  String get name {
    switch (this) {
      case UserRole.driver:
        return 'Driver';
      case UserRole.parent:
        return 'Parent';
      case UserRole.admin:
        return 'Admin';
      case UserRole.unknown:
        return 'Unknown';
    }
  }

  static UserRole fromString(String role) {
    switch (role.toLowerCase()) {
      case 'driver':
        return UserRole.driver;
      case 'parent':
        return UserRole.parent;
      case 'admin':
        return UserRole.admin;
      default:
        return UserRole.unknown;
    }
  }
}