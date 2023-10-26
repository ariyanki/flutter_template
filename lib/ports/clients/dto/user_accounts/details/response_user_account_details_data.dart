import 'package:flutter/foundation.dart';
import 'package:flutter_template/ports/clients/dto/common/permission_item.dart';
import 'package:flutter_template/utils/check_optional.dart';
import 'package:quiver/core.dart';

@immutable
class ResponseUserAccountDetailsData {

  const ResponseUserAccountDetailsData({
    required this.id,
    required this.userName,
    this.fullName,
    required this.email,
    this.phoneNumber,
    this.roleId,
    required this.permissions,
    this.status,
    required this.updatedDate,
    required this.createdDate,
    required this.lastActiveDate,
    required this.lastLogin,
    required this.lastLogout,
    required this.loggedInAt,
    required this.isPendingForDeactivated,
    required this.isPendingForUnlock,
    required this.transactionLimit,
    required this.approvalLimit,
    required this.hasVcc,
  });

  final String id;
  final String userName;
  final String? fullName;
  final String email;
  final String? phoneNumber;
  final String? roleId;
  final List<PermissionItem> permissions;
  final String? status;
  final String updatedDate;
  final String createdDate;
  final String lastActiveDate;
  final String lastLogin;
  final String lastLogout;
  final String loggedInAt;
  final bool isPendingForDeactivated;
  final bool isPendingForUnlock;
  final int transactionLimit;
  final int approvalLimit;
  final bool hasVcc;

  factory ResponseUserAccountDetailsData.fromJson(Map<String,dynamic> json) => ResponseUserAccountDetailsData(
    id: json['id'].toString(),
    userName: json['userName'].toString(),
    fullName: json['fullName']?.toString(),
    email: json['email'].toString(),
    phoneNumber: json['phoneNumber']?.toString(),
    roleId: json['roleId']?.toString(),
    permissions: (json['permissions'] as List? ?? []).map((e) => PermissionItem.fromJson(e as Map<String, dynamic>)).toList(),
    status: json['status']?.toString(),
    updatedDate: json['updatedDate'].toString(),
    createdDate: json['createdDate'].toString(),
    lastActiveDate: json['lastActiveDate'].toString(),
    lastLogin: json['lastLogin'].toString(),
    lastLogout: json['lastLogout'].toString(),
    loggedInAt: json['loggedInAt'].toString(),
    isPendingForDeactivated: json['isPendingForDeactivated'] as bool,
    isPendingForUnlock: json['isPendingForUnlock'] as bool,
    transactionLimit: json['transactionLimit'] as int,
    approvalLimit: json['approvalLimit'] as int,
    hasVcc: json['hasVcc'] as bool
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
    'updatedDate': updatedDate,
    'createdDate': createdDate,
    'lastActiveDate': lastActiveDate,
    'lastLogin': lastLogin,
    'lastLogout': lastLogout,
    'loggedInAt': loggedInAt,
    'isPendingForDeactivated': isPendingForDeactivated,
    'isPendingForUnlock': isPendingForUnlock,
    'transactionLimit': transactionLimit,
    'approvalLimit': approvalLimit,
    'hasVcc': hasVcc
  };

  ResponseUserAccountDetailsData clone() => ResponseUserAccountDetailsData(
    id: id,
    userName: userName,
    fullName: fullName,
    email: email,
    phoneNumber: phoneNumber,
    roleId: roleId,
    permissions: permissions.map((e) => e.clone()).toList(),
    status: status,
    updatedDate: updatedDate,
    createdDate: createdDate,
    lastActiveDate: lastActiveDate,
    lastLogin: lastLogin,
    lastLogout: lastLogout,
    loggedInAt: loggedInAt,
    isPendingForDeactivated: isPendingForDeactivated,
    isPendingForUnlock: isPendingForUnlock,
    transactionLimit: transactionLimit,
    approvalLimit: approvalLimit,
    hasVcc: hasVcc
  );


  ResponseUserAccountDetailsData copyWith({
    String? id,
    String? userName,
    Optional<String?>? fullName,
    String? email,
    Optional<String?>? phoneNumber,
    Optional<String?>? roleId,
    List<PermissionItem>? permissions,
    Optional<String?>? status,
    String? updatedDate,
    String? createdDate,
    String? lastActiveDate,
    String? lastLogin,
    String? lastLogout,
    String? loggedInAt,
    bool? isPendingForDeactivated,
    bool? isPendingForUnlock,
    int? transactionLimit,
    int? approvalLimit,
    bool? hasVcc
  }) => ResponseUserAccountDetailsData(
    id: id ?? this.id,
    userName: userName ?? this.userName,
    fullName: checkOptional(fullName, () => this.fullName),
    email: email ?? this.email,
    phoneNumber: checkOptional(phoneNumber, () => this.phoneNumber),
    roleId: checkOptional(roleId, () => this.roleId),
    permissions: permissions ?? this.permissions,
    status: checkOptional(status, () => this.status),
    updatedDate: updatedDate ?? this.updatedDate,
    createdDate: createdDate ?? this.createdDate,
    lastActiveDate: lastActiveDate ?? this.lastActiveDate,
    lastLogin: lastLogin ?? this.lastLogin,
    lastLogout: lastLogout ?? this.lastLogout,
    loggedInAt: loggedInAt ?? this.loggedInAt,
    isPendingForDeactivated: isPendingForDeactivated ?? this.isPendingForDeactivated,
    isPendingForUnlock: isPendingForUnlock ?? this.isPendingForUnlock,
    transactionLimit: transactionLimit ?? this.transactionLimit,
    approvalLimit: approvalLimit ?? this.approvalLimit,
    hasVcc: hasVcc ?? this.hasVcc,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is ResponseUserAccountDetailsData && id == other.id && userName == other.userName && fullName == other.fullName && email == other.email && phoneNumber == other.phoneNumber && roleId == other.roleId && permissions == other.permissions && status == other.status && updatedDate == other.updatedDate && createdDate == other.createdDate && lastActiveDate == other.lastActiveDate && lastLogin == other.lastLogin && lastLogout == other.lastLogout && loggedInAt == other.loggedInAt && isPendingForDeactivated == other.isPendingForDeactivated && isPendingForUnlock == other.isPendingForUnlock && transactionLimit == other.transactionLimit && approvalLimit == other.approvalLimit && hasVcc == other.hasVcc;

  @override
  int get hashCode => id.hashCode ^ userName.hashCode ^ fullName.hashCode ^ email.hashCode ^ phoneNumber.hashCode ^ roleId.hashCode ^ permissions.hashCode ^ status.hashCode ^  updatedDate.hashCode ^ createdDate.hashCode ^ lastActiveDate.hashCode ^ lastLogin.hashCode ^ lastLogout.hashCode ^ loggedInAt.hashCode ^ isPendingForDeactivated.hashCode ^ isPendingForUnlock.hashCode ^ transactionLimit.hashCode ^ approvalLimit.hashCode ^ hasVcc.hashCode;
}
