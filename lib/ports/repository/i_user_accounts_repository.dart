import 'package:flutter_template/ports/repository/dto/user_account_details.dart';

abstract class IUserAccountsRepository {
  UserAccountDetails? getUserAccountDetail();

  Future<bool> saveUserAccountData(
      UserAccountDetails userAccountDetailData);
}