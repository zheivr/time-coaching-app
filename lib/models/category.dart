import 'package:flutter/material.dart';

class Category {
  final int id;
  final String name;
  final String color; // HEX: #RRGGBB
  final String? iconName;
  final int orderIndex;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.color,
    this.iconName,
    required this.orderIndex,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert HEX color string to Color
  Color get colorValue {
    final hexString = color.replaceFirst('#', '');
    return Color(int.parse('FF$hexString', radix: 16));
  }

  // Convert to Map for database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'icon_name': iconName,
      'order_index': orderIndex,
      'is_active': isActive ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Create from Map
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as int,
      name: map['name'] as String,
      color: map['color'] as String,
      iconName: map['icon_name'] as String?,
      orderIndex: map['order_index'] as int,
      isActive: (map['is_active'] as int) == 1,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  // Copy with method
  Category copyWith({
    int? id,
    String? name,
    String? color,
    String? iconName,
    int? orderIndex,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      iconName: iconName ?? this.iconName,
      orderIndex: orderIndex ?? this.orderIndex,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() => 'Category(id: $id, name: $name, color: $color)';
}
