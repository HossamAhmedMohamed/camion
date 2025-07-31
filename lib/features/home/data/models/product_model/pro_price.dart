class ProPrice {
	int? priceCent;
	int? price;

	ProPrice({this.priceCent, this.price});

	factory ProPrice.fromJson(Map<String, dynamic> json) => ProPrice(
				  priceCent: (json['priceCent'] as num).toInt(),
        price: (json['price'] as num).toInt(),
			);

	Map<String, dynamic> toJson() => {
				'priceCent': priceCent,
				'price': price,
			};
}
