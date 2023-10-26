import 'package:flutter/foundation.dart';
import 'package:flutter_template/utils/check_optional.dart';
import 'package:quiver/core.dart';

@immutable
class UserCredentials {
  const UserCredentials({
    required this.isFirstLaunch,
    this.isEnableBiometricLogin,
    this.refreshToken,
    this.accessToken,
    this.username,
    this.roleId,
  });

  final bool isFirstLaunch;
  final bool? isEnableBiometricLogin;
  final String? refreshToken;
  final String? accessToken;
  final String? username;
  final String? roleId;

  factory UserCredentials.fromJson(Map<String, dynamic> json) =>
      UserCredentials(
        isFirstLaunch: json['isFirstLaunch'] as bool,
        isEnableBiometricLogin: json['isEnableBiometricLogin'] as bool?,
        refreshToken: json['refreshToken']?.toString(),
        accessToken: json['accessToken']?.toString(),
        username: json['username']?.toString(),
        roleId: json['roleId']?.toString(),
      );

  Map<String, dynamic> toJson() => {
        'isFirstLaunch': isFirstLaunch,
        'isEnableBiometricLogin': isEnableBiometricLogin,
        'refreshToken': refreshToken,
        'accessToken': accessToken,
        'username': username,
        'roleId': roleId,
      };

  UserCredentials clone() => UserCredentials(
        isFirstLaunch: isFirstLaunch,
        isEnableBiometricLogin: isEnableBiometricLogin,
        refreshToken: refreshToken,
        accessToken: accessToken,
        username: username,
        roleId: roleId,
      );

  UserCredentials copyWith({
    bool? isFirstLaunch,
    Optional<bool?>? isEnableBiometricLogin,
    Optional<String?>? refreshToken,
    Optional<String?>? accessToken,
    Optional<String?>? username,
    Optional<String?>? roleId,
  }) =>
      UserCredentials(
        isFirstLaunch: isFirstLaunch ?? this.isFirstLaunch,
        isEnableBiometricLogin: checkOptional(
            isEnableBiometricLogin, () => this.isEnableBiometricLogin),
        refreshToken: checkOptional(refreshToken, () => this.refreshToken),
        accessToken: checkOptional(accessToken, () => this.accessToken),
        username: checkOptional(username, () => this.username),
        roleId: checkOptional(roleId, () => this.roleId),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserCredentials &&
          isFirstLaunch == other.isFirstLaunch &&
          isEnableBiometricLogin == other.isEnableBiometricLogin &&
          refreshToken == other.refreshToken &&
          accessToken == other.accessToken &&
          username == other.username &&
          roleId == other.roleId;

  @override
  int get hashCode =>
      isFirstLaunch.hashCode ^
      isEnableBiometricLogin.hashCode ^
      refreshToken.hashCode ^
      accessToken.hashCode ^
      username.hashCode ^
      roleId.hashCode;
}
