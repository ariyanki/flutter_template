import 'package:flutter/foundation.dart';

@immutable
class UserAccountDetailsGroupsItem {

  const UserAccountDetailsGroupsItem({
    required this.id,
    required this.code,
    required this.name,
    required this.transactionLimit,
  });

  final int id;
  final String code;
  final String name;
  final int transactionLimit;

  factory UserAccountDetailsGroupsItem.fromJson(Map<String,dynamic> json) => UserAccountDetailsGroupsItem(
    id: json['id'] as int,
    code: json['code'].toString(),
    name: json['name'].toString(),
    transactionLimit: json['transactionLimit'] as int
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'code': code,
    'name': name,
    'transactionLimit': transactionLimit
  };

  // UserAccountDetailsGroupsItem clone() => UserAccountDetailsGroupsItem(
  //   id: id,
  //   code: code,
  //   name: name,
  //   transactionLimit: transactionLimit
  // );
  //
  //
  // UserAccountDetailsGroupsItem copyWith({
  //   int? id,
  //   String? code,
  //   String? name,
  //   int? transactionLimit
  // }) => UserAccountDetailsGroupsItem(
  //   id: id ?? this.id,
  //   code: code ?? this.code,
  //   name: name ?? this.name,
  //   transactionLimit: transactionLimit ?? this.transactionLimit,
  // );
  //
  // @override
  // bool operator ==(Object other) => identical(this, other)
  //   || other is UserAccountDetailsGroupsItem && id == other.id && code == other.code && name == other.name && transactionLimit == other.transactionLimit;
  //
  // @override
  // int get hashCode => id.hashCode ^ code.hashCode ^ name.hashCode ^ transactionLimit.hashCode;
}
