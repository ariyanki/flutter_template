import 'package:flutter/foundation.dart';

@immutable
class ResponseAuthSignInDataUser {

  const ResponseAuthSignInDataUser({
    required this.status,
    required this.roleId,
  });

  final String status;
  final String roleId;

  factory ResponseAuthSignInDataUser.fromJson(Map<String,dynamic> json) => ResponseAuthSignInDataUser(
    status: json['status'].toString(),
    roleId: json['roleId'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'status': status,
    'roleId': roleId
  };
}
