import 'package:flutter/material.dart';

class ChangeLanguageModel {
  final String languageCode;
  final String title;
  final VoidCallback? onTap;

  ChangeLanguageModel({required this.title, this.onTap , required this.languageCode});
}
