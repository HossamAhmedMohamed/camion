class Price {
  int priceCent;
  int price;

  Price({required this.priceCent, required this.price});

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        priceCent: (json['priceCent'] as num).toInt(),
        price: (json['price'] as num).toInt(),
      );

  Map<String, dynamic> toJson() => {
        'priceCent': priceCent,
        'price': price,
      };
}
