import 'package:flutter/foundation.dart';
import 'package:flutter_template/utils/check_optional.dart';
import 'package:quiver/core.dart';

@immutable
class Message {

  const Message({
    this.code,
    required this.isSuccess,
    required this.transactionId,
    required this.timestamp,
    this.detail,
    this.description,
    this.correlationId,
  });

  final String? code;
  final bool isSuccess;
  final String transactionId;
  final int timestamp;
  final String? detail;
  final String? description;
  final String? correlationId;

  factory Message.fromJson(Map<String,dynamic> json) => Message(
    code: json['code']?.toString(),
    isSuccess: json['isSuccess'] as bool,
    transactionId: json['transactionId'].toString(),
    timestamp: json['timestamp'] as int,
    detail: json['detail']?.toString(),
    description: json['description']?.toString(),
    correlationId: json['correlationId']?.toString()
  );
  
  Map<String, dynamic> toJson() => {
    'code': code,
    'isSuccess': isSuccess,
    'transactionId': transactionId,
    'timestamp': timestamp,
    'detail': detail,
    'description': description,
    'correlationId': correlationId
  };

  Message clone() => Message(
    code: code,
    isSuccess: isSuccess,
    transactionId: transactionId,
    timestamp: timestamp,
    detail: detail,
    description: description,
    correlationId: correlationId
  );


  Message copyWith({
    Optional<String?>? code,
    bool? isSuccess,
    String? transactionId,
    int? timestamp,
    Optional<String?>? detail,
    Optional<String?>? description,
    Optional<String?>? correlationId
  }) => Message(
    code: checkOptional(code, () => this.code),
    isSuccess: isSuccess ?? this.isSuccess,
    transactionId: transactionId ?? this.transactionId,
    timestamp: timestamp ?? this.timestamp,
    detail: checkOptional(detail, () => this.detail),
    description: checkOptional(description, () => this.description),
    correlationId: checkOptional(correlationId, () => this.correlationId),
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Message && code == other.code && isSuccess == other.isSuccess && transactionId == other.transactionId && timestamp == other.timestamp && detail == other.detail && description == other.description && correlationId == other.correlationId;

  @override
  int get hashCode => code.hashCode ^ isSuccess.hashCode ^ transactionId.hashCode ^ timestamp.hashCode ^ detail.hashCode ^ description.hashCode ^ correlationId.hashCode;
}
