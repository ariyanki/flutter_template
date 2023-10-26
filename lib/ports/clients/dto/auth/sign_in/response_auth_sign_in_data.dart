import 'package:flutter/foundation.dart';

import 'response_auth_sign_in_data_user.dart';

@immutable
class ResponseAuthSignInData {

  const ResponseAuthSignInData({
    required this.token,
    required this.refreshToken,
    required this.user,
  });

  final String token;
  final String refreshToken;
  final ResponseAuthSignInDataUser user;

  factory ResponseAuthSignInData.fromJson(Map<String,dynamic> json) => ResponseAuthSignInData(
    token: json['token'].toString(),
    refreshToken: json['refreshToken'].toString(),
    user: ResponseAuthSignInDataUser.fromJson(json['user'] as Map<String, dynamic>)
  );
  
  Map<String, dynamic> toJson() => {
    'token': token,
    'refreshToken': refreshToken,
    'user': user.toJson()
  };
}
