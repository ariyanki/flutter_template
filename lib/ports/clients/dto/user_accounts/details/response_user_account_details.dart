import 'package:flutter/foundation.dart';
import 'package:flutter_template/ports/clients/dto/common/message.dart';
import 'package:flutter_template/ports/clients/dto/user_accounts/details/response_user_account_details_data.dart';
import 'package:flutter_template/utils/check_optional.dart';
import 'package:quiver/core.dart';

@immutable
class ResponseUserAccountDetails {

  const ResponseUserAccountDetails({
    required this.message,
    this.data,
  });

  final Message message;
  final ResponseUserAccountDetailsData? data;

  factory ResponseUserAccountDetails.fromJson(Map<String,dynamic> json) => ResponseUserAccountDetails(
    message: Message.fromJson(json['message'] as Map<String, dynamic>),
    data: json['data'] != null ? ResponseUserAccountDetailsData.fromJson(json['data'] as Map<String, dynamic>) : null
  );
  
  Map<String, dynamic> toJson() => {
    'message': message.toJson(),
    'data': data?.toJson()
  };

  ResponseUserAccountDetails clone() => ResponseUserAccountDetails(
    message: message.clone(),
    data: data?.clone()
  );


  ResponseUserAccountDetails copyWith({
    Message? message,
    Optional<ResponseUserAccountDetailsData?>? data
  }) => ResponseUserAccountDetails(
    message: message ?? this.message,
    data: checkOptional(data, () => this.data),
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is ResponseUserAccountDetails && message == other.message && data == other.data;

  @override
  int get hashCode => message.hashCode ^ data.hashCode;
}
