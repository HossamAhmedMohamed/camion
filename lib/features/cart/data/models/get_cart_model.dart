class GetCartModel {
	String? id;
	String? userId;
	String? productId;
	int? quantity;
	String? title;
	String? image;
	String? price;
	dynamic couponCode;
	int? discountPercentage;
	DateTime? createdAt;
	DateTime? updatedAt;

	GetCartModel({
		this.id, 
		this.userId, 
		this.productId, 
		this.quantity, 
		this.title, 
		this.image, 
		this.price, 
		this.couponCode, 
		this.discountPercentage, 
		this.createdAt, 
		this.updatedAt, 
	});

	factory GetCartModel.fromJson(Map<String, dynamic> json) => GetCartModel(
				id: json['id'] as String?,
				userId: json['userId'] as String?,
				productId: json['productId'] as String?,
				quantity: json['quantity'] as int?,
				title: json['title'] as String?,
				image: json['image'] as String?,
				price: json['price'] ,
				couponCode: json['couponCode'] as dynamic,
				discountPercentage: json['discountPercentage'] as int?,
				createdAt: json['createdAt'] == null
						? null
						: DateTime.parse(json['createdAt'] as String),
				updatedAt: json['updatedAt'] == null
						? null
						: DateTime.parse(json['updatedAt'] as String),
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'userId': userId,
				'productId': productId,
				'quantity': quantity,
				'title': title,
				'image': image,
				'price': price,
				'couponCode': couponCode,
				'discountPercentage': discountPercentage,
				'createdAt': createdAt?.toIso8601String(),
				'updatedAt': updatedAt?.toIso8601String(),
			};
}
