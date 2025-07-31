class Shop {
  final String shopId;
  final String shopName;

  Shop({required this.shopId, required this.shopName});

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      shopId: json['shopId'],
      shopName: json['shopName'],
    );
  }
}