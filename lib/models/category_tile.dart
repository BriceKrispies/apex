import 'package:flutter/material.dart';

enum CategoryType { service, trucker }

class CategoryTile {
  final String id;
  final String label;
  final IconData icon;
  final CategoryType type;

  const CategoryTile({
    required this.id,
    required this.label,
    required this.icon,
    this.type = CategoryType.service,
  });
}
