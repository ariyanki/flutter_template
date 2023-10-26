import 'package:flutter/foundation.dart';

import '../../common/message.dart';
import 'response_auth_sign_in_data.dart';

@immutable
class ResponseAuthSignIn {

  const ResponseAuthSignIn({
    required this.message,
    required this.data,
  });

  final Message message;
  final ResponseAuthSignInData data;

  factory ResponseAuthSignIn.fromJson(Map<String,dynamic> json) => ResponseAuthSignIn(
    message: Message.fromJson(json['message'] as Map<String, dynamic>),
    data: ResponseAuthSignInData.fromJson(json['data'] as Map<String, dynamic>)
  );
  
  Map<String, dynamic> toJson() => {
    'message': message.toJson(),
    'data': data.toJson()
  };
}
