import 'package:flutter_template/ports/clients/dto/common/permission_item.dart';
import 'package:flutter_template/ports/clients/dto/user_accounts/details/response_user_account_details.dart';
import 'package:flutter_template/ports/clients/dto/user_accounts/details/response_user_account_details_data.dart';
import 'package:flutter_template/ports/enum/permission_resource.dart';
import 'package:flutter_template/ports/enum/user_role_acl.dart';

import 'common_fake_data.dart';

class UserAccountDetailFakeData {
  static ResponseUserAccountDetails successResponseWithRole(UserRoleACL role,
      [String actionsIndividualVcc = '*']) {
    return ResponseUserAccountDetails(
      message: CommonFakeData.successMessage,
      data: ResponseUserAccountDetailsData(
        id: '1',
        userName: 'userName',
        fullName: 'fullname',
        email: 'email',
        roleId: role.id,
        phoneNumber: '+62812345678',
        permissions: [
          PermissionItem(
            actions: const ["*"],
            resource: PermissionResource.transaction.value,
          ),
          if (role == UserRoleACL.admin)
            PermissionItem(
              actions: const ["*"],
              resource: PermissionResource.transaction.value,
            ),
        ],
        updatedAt: 'updatedDate',
        createdAt: 'createdDate',
        lastAccessAt: 'lastActiveDate',
        lastLoggedinAt: "2023-03-16T09:19:52",
      ),
    );
  }

  static var jsonResponse = {
    "message": CommonFakeData.successMessage.toJson(),
    "data": {
      "id": 122,
      "userName": "user1",
      "fullName": "fullName",
      "email": "user@gmail.com",
      "phoneNumber": "0123456789",
      "roleId": "id_user",
      "status": "Active",
      "permissions": [
        {
          "actions": ["*"],
          "resource": "transaction"
        },
      ],
      "updatedAt": "02/12/2021 12:07:13",
      "createdAt": "02/12/2021 12:07:13",
      "lastAccessAt": "02/12/2021 12:07:13",
      "lastLoggedinAt": "2023-03-16T09:19:52"
    }
  };

  static var jsonResponseData = {
    "id": 123,
    "userName": "user2",
    "fullName": "Fullname 2",
    "email": "user2@gmail.com",
    "phoneNumber": "0123456789",
    "roleId": "id_admin",
    "status": "Active",
    "permissions": [
      {
        "actions": ["*"],
        "resource": "transaction"
      },
    ],
    "updatedAt": "02/12/2021 12:07:13",
    "createdAt": "02/12/2021 12:07:13",
    "lastAccessAt": "02/12/2021 12:07:13",
    "lastLoggedinAt": "2023-03-16T09:19:52"
  };
}
