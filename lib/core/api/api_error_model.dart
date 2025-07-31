import 'package:flutter/widgets.dart';

class ApiErrorModel {
  final String message;
  final IconData? icon;
  final int? statusCode;

  ApiErrorModel({required this.message, this.icon, this.statusCode});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    return ApiErrorModel(
      message: _parseErrorMessage(json),
    );
  }

  static String _parseErrorMessage(Map<String, dynamic> json) {
    try {
      if (json['errors'] != null && json['errors'] is List) {
        final errors = json['errors'];
        return errors.map((e) => e.toString()).join('\n');
      } else if (json['message'] != null) {
        return json['message'];
      } else {
        return 'Unknown error occurred';
      }
    } catch (e) {
      return 'Internal Server Error';
    }
  }
}
