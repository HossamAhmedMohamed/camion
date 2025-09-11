import 'package:flutter/material.dart';

class ChangeLanguageModel {
  final String languageCode;
  final String title;
  final VoidCallback? onTap;
  final bool isSelected ;

  ChangeLanguageModel({required this.title, this.onTap , required this.languageCode ,required this.isSelected });
}
