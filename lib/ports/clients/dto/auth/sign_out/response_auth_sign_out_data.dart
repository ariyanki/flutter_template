import 'package:flutter/foundation.dart';

@immutable
class ResponseAuthSignOutData {

  const ResponseAuthSignOutData({
    required this.status,
  });

  final String status;

  factory ResponseAuthSignOutData.fromJson(Map<String,dynamic> json) => ResponseAuthSignOutData(
    status: json['status'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'status': status
  };

  ResponseAuthSignOutData clone() => ResponseAuthSignOutData(
    status: status
  );


  ResponseAuthSignOutData copyWith({
    String? status
  }) => ResponseAuthSignOutData(
    status: status ?? this.status,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is ResponseAuthSignOutData && status == other.status;

  @override
  int get hashCode => status.hashCode;
}
