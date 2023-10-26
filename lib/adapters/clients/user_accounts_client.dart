import 'package:flutter_template/adapters/clients/network/dio_configure.dart';
import 'package:flutter_template/adapters/clients/network/endpoint.dart';
import 'package:flutter_template/ports/clients/dto/user_accounts/details/response_user_account_details.dart';
import 'package:flutter_template/ports/clients/dto/user_accounts/details/response_user_account_details_data.dart';
import 'package:flutter_template/ports/clients/i_user_accounts_client.dart';
import 'package:flutter_template/ports/repository/dto/user_account_details.dart';
import 'package:flutter_template/ports/repository/i_user_accounts_repository.dart';
import 'package:get/get.dart';

class UserAccountsClientImpl implements IUserAccountsClient {
  final IUserAccountsRepository _userAccountLocalRepository =
      Get.find<IUserAccountsRepository>();
  final dioConfigure = Get.find<DioConfigure>();
  final endpoints = Get.find<Endpoints>();

  UserAccountDetails? _userDetailsCache;

  @override
  Future<ResponseUserAccountDetails> getUserAccountDetails({
    bool caching = true,
  }) async {
    ResponseUserAccountDetails? responseUserAccountDetails;
    if (caching) {
      if (_userDetailsCache == null) {
        var response = await dioConfigure.dioIAM.get(
          endpoints.userAccounts.details,
        );
        responseUserAccountDetails = ResponseUserAccountDetails.fromJson(response.data);

        _userDetailsCache = UserAccountDetails.fromJson(response.data);
        await _userAccountLocalRepository
            .saveUserAccountData(_userDetailsCache!);
      }
      return responseUserAccountDetails!;
    } else {
      var response = await dioConfigure.dioIAM.get(
        endpoints.userAccounts.details,
      );
      responseUserAccountDetails = ResponseUserAccountDetails.fromJson(response.data);

      _userDetailsCache = UserAccountDetails.fromJson(response.data);
      await _userAccountLocalRepository
          .saveUserAccountData(_userDetailsCache!);
      return responseUserAccountDetails!;
    }
  }

  @override
  ResponseUserAccountDetailsData? getLocalUserAccountDetails() {
    var localData = _userAccountLocalRepository.getUserAccountDetail();
    return ResponseUserAccountDetailsData.fromJson(localData!.toJson());
  }
}
