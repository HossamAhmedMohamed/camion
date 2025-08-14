class GetCouponsModel {
  final String id;
  final String code;
  final bool isActive;
  final Affiliate affiliate;
  final double discountPercentage;
  final DateTime createdAt;

  GetCouponsModel({
    required this.id,
    required this.code,
    required this.isActive,
    required this.affiliate,
    required this.discountPercentage,
    required this.createdAt,
  });

  factory GetCouponsModel.fromJson(Map<String, dynamic> json) {
    return GetCouponsModel(
      id: json['id'],
      code: json['code'],
      isActive: json['isActive'],
      affiliate: Affiliate.fromJson(json['affiliate']),
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'isActive': isActive,
      'affiliate': affiliate.toJson(),
      'discountPercentage': discountPercentage,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class Affiliate {
  final String id;
  final String userId;
  final String fullName;
  final String gender;
  final String nationality;
  final String status;
  final double totalEarnings;
  final int couponsCreated;
  final String bio;
  final String? referralLink;
  final DateTime createdAt;
  final DateTime updatedAt;

  Affiliate({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.gender,
    required this.nationality,
    required this.status,
    required this.totalEarnings,
    required this.couponsCreated,
    required this.bio,
    this.referralLink,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Affiliate.fromJson(Map<String, dynamic> json) {
    return Affiliate(
      id: json['id'],
      userId: json['userId'],
      fullName: json['fullName'],
      gender: json['gender'],
      nationality: json['nationality'],
      status: json['status'],
      totalEarnings: (json['totalEarnings'] as num).toDouble(),
      couponsCreated: json['couponsCreated'],
      bio: json['bio'],
      referralLink: json['referralLink'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'fullName': fullName,
      'gender': gender,
      'nationality': nationality,
      'status': status,
      'totalEarnings': totalEarnings,
      'couponsCreated': couponsCreated,
      'bio': bio,
      'referralLink': referralLink,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
