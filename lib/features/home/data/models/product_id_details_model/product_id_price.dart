class ProductIdPrice {
    int priceCent;
    int price;

  ProductIdPrice({required this.priceCent, required this.price});

  factory ProductIdPrice.fromJson(Map<String, dynamic> json) {
    return ProductIdPrice(
      priceCent: (json['priceCent'] as num).toInt(),
      price: (json['price'] as num).toInt(),
    );
  }
}
