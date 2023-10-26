import 'package:flutter/foundation.dart';

@immutable
class RequestAuthRefresh {

  const RequestAuthRefresh({
    required this.accessToken,
    required this.refreshToken,
  });

  final String accessToken;
  final String refreshToken;

  factory RequestAuthRefresh.fromJson(Map<String,dynamic> json) => RequestAuthRefresh(
    accessToken: json['accessToken'].toString(),
    refreshToken: json['refreshToken'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'accessToken': accessToken,
    'refreshToken': refreshToken
  };

  RequestAuthRefresh clone() => RequestAuthRefresh(
    accessToken: accessToken,
    refreshToken: refreshToken
  );


  RequestAuthRefresh copyWith({
    String? accessToken,
    String? refreshToken
  }) => RequestAuthRefresh(
    accessToken: accessToken ?? this.accessToken,
    refreshToken: refreshToken ?? this.refreshToken,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is RequestAuthRefresh && accessToken == other.accessToken && refreshToken == other.refreshToken;

  @override
  int get hashCode => accessToken.hashCode ^ refreshToken.hashCode;
}
