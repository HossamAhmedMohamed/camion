import 'package:flutter/material.dart';

class ProfileModel {
  final String image;
  final String title;
  final VoidCallback? onTap;
  final String? subTitle;
  ProfileModel({
    required this.image,
    required this.title,
    this.onTap,
    this.subTitle,
  });
}
