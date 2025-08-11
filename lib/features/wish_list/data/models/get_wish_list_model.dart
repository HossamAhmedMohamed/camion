class GetWishListModel {
	String? id;
	String? userId;
	String? productId;
	String? productName;
	String? productImage;
	String? price;

	GetWishListModel({
		this.id, 
		this.userId, 
		this.productId, 
		this.productName, 
		this.productImage, 
		this.price, 
	});

	factory GetWishListModel.fromJson(Map<String, dynamic> json) {
		return GetWishListModel(
			id: json['id'] as String?,
			userId: json['userId'] as String?,
			productId: json['productId'] as String?,
			productName: json['productName'] as String?,
			productImage: json['productImage'] as String?,
			price: json['price'] ,
		);
	}



	Map<String, dynamic> toJson() => {
				'id': id,
				'userId': userId,
				'productId': productId,
				'productName': productName,
				'productImage': productImage,
				'price': price,
			};
}
