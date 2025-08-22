import 'package:camion/features/auth/data/models/verify_model/user_model.dart';

class VerifyModel {
  final String accessToken;
  final UserModel user;
  final bool isFirstLogin;

  VerifyModel({
    required this.accessToken,
    required this.user,
    required this.isFirstLogin,
  });

  factory VerifyModel.fromJson(Map<String, dynamic> json) {
    return VerifyModel(
      accessToken: json['accessToken'],
      user: UserModel.fromJson(json['user']),
      isFirstLogin: json['isFirstLogin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'accessToken': accessToken, 'user': user.toJson()};
  }
}
