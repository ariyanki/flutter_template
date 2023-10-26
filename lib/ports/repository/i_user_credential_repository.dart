import 'package:flutter_template/ports/repository/dto/user_credentials.dart';

abstract class IUserCredentialsRepository {
  Future<bool> saveToken({
    required String refreshToken,
    required String accessToken,
  });

  UserCredentials getCredentials();

  Future<bool> clearCredentials();

  Future<bool> updateCredentials(UserCredentials credentials);
}
