import 'package:collection/collection.dart';

enum UserRoleACL {
  admin('id_admin', 'Admin'),
  user('id_user', 'User');

  final String id;
  final String value;
  const UserRoleACL(this.id, this.value);

  static UserRoleACL? fromRoleId(String? roleId) {
    return UserRoleACL.values.firstWhereOrNull(
      (element) => element.id == roleId,
    );
  }
}
