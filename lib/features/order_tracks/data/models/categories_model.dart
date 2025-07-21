import 'package:flutter/material.dart';

class CategoriesModel {
  final VoidCallback onTap;
  final String title;
  final String? image;
  const CategoriesModel({
    required this.onTap,
    required this.title,
    this.image,
  });
}
