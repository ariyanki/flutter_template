import 'dart:convert';

import 'package:flutter_template/ports/repository/dto/user_credentials.dart';
import 'package:flutter_template/ports/repository/i_user_credential_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quiver/core.dart';

class UserCredentialsRepositoryImpl implements IUserCredentialsRepository {
  final _sharedPreferences = Get.find<SharedPreferences>();

  static const key = 'user_credentials';

  @override
  UserCredentials getCredentials() {
    final rawCredentials = _sharedPreferences.getString(key);
    if (rawCredentials == null) {
      return const UserCredentials(isFirstLaunch: true);
    } else {
      return UserCredentials.fromJson(
        jsonDecode(rawCredentials),
      );
    }
  }

  @override
  Future<bool> saveToken({
    required String refreshToken,
    required String accessToken,
  }) {
    final credential = getCredentials();
    return updateCredentials(
      credential.copyWith(
        accessToken: Optional.of(accessToken),
        refreshToken: Optional.of(refreshToken),
      ),
    );
  }

  @override
  Future<bool> updateCredentials(UserCredentials credentials) {
    return _sharedPreferences.setString(
      key,
      jsonEncode(credentials.toJson()),
    );
  }

  @override
  Future<bool> clearCredentials() {
    final credential = getCredentials();
    return updateCredentials(
      credential.copyWith(
        isFirstLaunch: true,
        isEnableBiometricLogin: const Optional.fromNullable(false),
        accessToken: const Optional.absent(),
        refreshToken: const Optional.absent(),
        username: const Optional.absent(),
        roleId: const Optional.absent(),
      ),
    );
  }
}
