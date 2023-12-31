import 'package:flutter/foundation.dart';

@immutable
class RequestAuthSignIn {

  const RequestAuthSignIn({
    required this.username,
    required this.password,
    required this.rememberMe,
  });

  final String username;
  final String password;
  final bool rememberMe;

  factory RequestAuthSignIn.fromJson(Map<String,dynamic> json) => RequestAuthSignIn(
    username: json['username'].toString(),
    password: json['password'].toString(),
    rememberMe: json['rememberMe'] as bool
  );
  
  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
    'rememberMe': rememberMe
  };
}
