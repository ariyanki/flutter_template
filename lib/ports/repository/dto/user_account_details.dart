import 'package:flutter/foundation.dart';
import 'package:flutter_template/ports/repository/dto/permission_item.dart';

@immutable
class UserAccountDetails {

  final String id;
  final String userName;
  final String? fullName;
  final String email;
  final String? phoneNumber;
  final String? roleId;
  final List<PermissionItem> permissions;
  final String? status;
  final String updatedAt;
  final String createdAt;
  final String lastLoggedinAt;
  final String lastAccessAt;

  const UserAccountDetails({
    required this.id,
    required this.userName,
    this.fullName,
    required this.email,
    this.phoneNumber,
    this.roleId,
    required this.permissions,
    this.status,
    required this.updatedAt,
    required this.createdAt,
    required this.lastLoggedinAt,
    required this.lastAccessAt,
  });

  factory UserAccountDetails.fromJson(Map<String,dynamic> json) => UserAccountDetails(
    id: json['id'].toString(),
    userName: json['userName'].toString(),
    fullName: json['fullName']?.toString(),
    email: json['email'].toString(),
    phoneNumber: json['phoneNumber']?.toString(),
    roleId: json['roleId']?.toString(),
    permissions: (json['permissions'] as List? ?? []).map((e) => PermissionItem.fromJson(e as Map<String, dynamic>)).toList(),
    status: json['status']?.toString(),
    updatedAt: json['updatedAt'].toString(),
    createdAt: json['createdAt'].toString(),
    lastLoggedinAt: json['lastLoggedinAt'].toString(),
    lastAccessAt: json['lastAccessAt'].toString(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'userName': userName,
    'fullName': fullName,
    'email': email,
    'phoneNumber': phoneNumber,
    'roleId': roleId,
    'permissions': permissions.map((e) => e.toJson()).toList(),
    'status': status,
    'updatedAt': updatedAt,
    'createdAt': createdAt,
    'lastLoggedinAt': lastLoggedinAt,
    'lastAccessAt': lastAccessAt,
  };
}
