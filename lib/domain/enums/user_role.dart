enum UserRole {
  admin,
  employee;

  bool get canManageProducts => this == UserRole.admin;

  bool get canManageUsers => this == UserRole.admin;
}
