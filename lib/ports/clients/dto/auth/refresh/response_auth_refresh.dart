import 'package:flutter/foundation.dart';

import 'response_auth_refresh_data.dart';
import '../../common/message.dart';

@immutable
class ResponseAuthRefresh {

  const ResponseAuthRefresh({
    required this.message,
    required this.data,
  });

  final Message message;
  final ResponseAuthRefreshData data;

  factory ResponseAuthRefresh.fromJson(Map<String,dynamic> json) => ResponseAuthRefresh(
    message: Message.fromJson(json['message'] as Map<String, dynamic>),
    data: ResponseAuthRefreshData.fromJson(json['data'] as Map<String, dynamic>)
  );
  
  Map<String, dynamic> toJson() => {
    'message': message.toJson(),
    'data': data.toJson()
  };

  ResponseAuthRefresh clone() => ResponseAuthRefresh(
    message: message.clone(),
    data: data.clone()
  );


  ResponseAuthRefresh copyWith({
    Message? message,
    ResponseAuthRefreshData? data
  }) => ResponseAuthRefresh(
    message: message ?? this.message,
    data: data ?? this.data,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is ResponseAuthRefresh && message == other.message && data == other.data;

  @override
  int get hashCode => message.hashCode ^ data.hashCode;
}
