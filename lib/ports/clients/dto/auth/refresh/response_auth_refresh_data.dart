import 'package:flutter/foundation.dart';

@immutable
class ResponseAuthRefreshData {

  const ResponseAuthRefreshData({
    required this.token,
    required this.refresh,
  });

  final String token;
  final String refresh;

  factory ResponseAuthRefreshData.fromJson(Map<String,dynamic> json) => ResponseAuthRefreshData(
    token: json['token'].toString(),
    refresh: json['refresh'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'token': token,
    'refresh': refresh
  };

  ResponseAuthRefreshData clone() => ResponseAuthRefreshData(
    token: token,
    refresh: refresh
  );


  ResponseAuthRefreshData copyWith({
    String? token,
    String? refresh
  }) => ResponseAuthRefreshData(
    token: token ?? this.token,
    refresh: refresh ?? this.refresh,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is ResponseAuthRefreshData && token == other.token && refresh == other.refresh;

  @override
  int get hashCode => token.hashCode ^ refresh.hashCode;
}
