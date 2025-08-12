class AffiliateModel {
  final String id;
  final String userId;
  final String fullName;
  final String gender;
  final String nationality;
  final String status;
  final int totalEarnings;
  final int couponsCreated;
  final String bio;
  final String? referralLink;
  final DateTime createdAt;
  final DateTime updatedAt;

  AffiliateModel({
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

  factory AffiliateModel.fromJson(Map<String, dynamic> json) {
    return AffiliateModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      fullName: json['fullName'] as String,
      gender: json['gender'] as String,
      nationality: json['nationality'] as String,
      status: json['status'] as String,
      totalEarnings: json['totalEarnings'] as int,
      couponsCreated: json['couponsCreated'] as int,
      bio: json['bio'] as String,
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
