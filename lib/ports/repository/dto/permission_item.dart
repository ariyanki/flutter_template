import 'package:flutter/foundation.dart';

@immutable
class PermissionItem {

  const PermissionItem({
    required this.actions,
    required this.resource,
  });

  final List<String> actions;
  final String resource;

  factory PermissionItem.fromJson(Map<String,dynamic> json) => PermissionItem(
    actions: (json['actions'] as List? ?? []).map((e) => e as String).toList(),
    resource: json['resource'].toString()
  );

  Map<String, dynamic> toJson() => {
    'actions': actions.map((e) => e.toString()).toList(),
    'resource': resource
  };

  // PermissionItem clone() => PermissionItem(
  //   actions: actions.toList(),
  //   resource: resource
  // );
  //
  //
  // PermissionItem copyWith({
  //   List<String>? actions,
  //   String? resource
  // }) => PermissionItem(
  //   actions: actions ?? this.actions,
  //   resource: resource ?? this.resource,
  // );
  //
  // @override
  // bool operator ==(Object other) => identical(this, other)
  //   || other is PermissionItem && actions == other.actions && resource == other.resource;
  //
  // @override
  // int get hashCode => actions.hashCode ^ resource.hashCode;
}
