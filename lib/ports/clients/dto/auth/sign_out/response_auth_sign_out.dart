import 'package:flutter/foundation.dart';

import '../../common/message.dart';
import 'response_auth_sign_out_data.dart';

@immutable
class ResponseAuthSignOut {

  const ResponseAuthSignOut({
    required this.message,
    required this.data,
  });

  final Message message;
  final ResponseAuthSignOutData data;

  factory ResponseAuthSignOut.fromJson(Map<String,dynamic> json) => ResponseAuthSignOut(
    message: Message.fromJson(json['message'] as Map<String, dynamic>),
    data: ResponseAuthSignOutData.fromJson(json['data'] as Map<String, dynamic>)
  );
  
  Map<String, dynamic> toJson() => {
    'message': message.toJson(),
    'data': data.toJson()
  };

  ResponseAuthSignOut clone() => ResponseAuthSignOut(
    message: message.clone(),
    data: data.clone()
  );


  ResponseAuthSignOut copyWith({
    Message? message,
    ResponseAuthSignOutData? data
  }) => ResponseAuthSignOut(
    message: message ?? this.message,
    data: data ?? this.data,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is ResponseAuthSignOut && message == other.message && data == other.data;

  @override
  int get hashCode => message.hashCode ^ data.hashCode;
}
