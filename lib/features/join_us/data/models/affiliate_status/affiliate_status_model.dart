class AffiliateStatus {
  final String affiliateId;
  final String fullName;
  final String status;
  final String? token;

  AffiliateStatus({
    required this.affiliateId,
    required this.fullName,
    required this.status,
    required this.token,
  });

  factory AffiliateStatus.fromJson(Map<String, dynamic> json) {
    return AffiliateStatus(
      affiliateId: json['affiliateId'] as String,
      fullName: json['fullName'] as String,
      status: json['status'] as String,
      token: json['token'] as String? ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'affiliateId': affiliateId,
      'fullName': fullName,
      'status': status,
      'token': token,
    };
  }
}
