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
}
