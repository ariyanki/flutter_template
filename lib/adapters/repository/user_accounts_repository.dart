import 'dart:convert';
import 'package:flutter_template/ports/repository/dto/user_account_details.dart';
import 'package:flutter_template/ports/repository/i_user_accounts_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAccountsRepositoryImpl implements IUserAccountsRepository {
  final _sharedPreferences = Get.find<SharedPreferences>();

  static const key = 'user_account';

  @override
  UserAccountDetails? getUserAccountDetail() {
    final rawUserAccountData = _sharedPreferences.getString(key);
    if (rawUserAccountData == null) {
      return null;
    } else {
      return UserAccountDetails.fromJson(
        jsonDecode(rawUserAccountData),
      );
    }
  }

  @override
  Future<bool> saveUserAccountData(
      UserAccountDetails userAccountDetailData) {
    return _sharedPreferences.setString(
      key,
      jsonEncode(
        userAccountDetailData.toJson(),
      ),
    );
  }
}
