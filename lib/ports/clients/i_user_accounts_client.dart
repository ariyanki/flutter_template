import 'package:flutter_template/ports/clients/dto/user_accounts/details/response_user_account_details.dart';
import 'package:flutter_template/ports/clients/dto/user_accounts/details/response_user_account_details_data.dart';

abstract class IUserAccountsClient {
  Future<ResponseUserAccountDetails> getUserAccountDetails({
    bool caching = true,
  });

  ResponseUserAccountDetailsData? getLocalUserAccountDetails();
}