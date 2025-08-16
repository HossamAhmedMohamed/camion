class GetUserModel {
  final String id;
  final String email;
  final String phone;
  final String? password;
  final String fullName;
  final bool isActive;
  final String code;
  final String role;
  final String notificationToken;
  final DateTime createdAt;
  final DateTime updatedAt;

  GetUserModel({
    required this.id,
    required this.email,
    required this.phone,
    this.password,
    required this.fullName,
    required this.isActive,
    required this.code,
    required this.role,
    required this.notificationToken,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GetUserModel.fromJson(Map<String, dynamic> json) {
    return GetUserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      password: json['password'],
      fullName: json['fullName'] ?? '',
      isActive: json['isActive'] ?? false,
      code: json['code'] ?? '',
      role: json['role'] ?? '',
      notificationToken: json['notificationToken'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'password': password,
      'fullName': fullName,
      'isActive': isActive,
      'code': code,
      'role': role,
      'notificationToken': notificationToken,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
