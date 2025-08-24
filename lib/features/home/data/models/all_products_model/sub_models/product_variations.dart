class ProductVariations {
  final int id;
  final List<ProductAttribute> attributes;
  final String? image;
  final num price;
  final num regularPrice;
  final num salePrice;
  final int stockQuantity;
  final String? stockStatus;

  ProductVariations({
    required this.id,
    required this.attributes,
    required this.image,
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    required this.stockQuantity,
    required this.stockStatus,
  });

  factory ProductVariations.fromJson(Map<String, dynamic> json) {
    return ProductVariations(
      id: json['id'],
      attributes: (json['attributes'] as List)
          .map((attr) => ProductAttribute.fromJson(attr))
          .toList(),
      image: json['image'] ?? '',
      price: json['price'] ?? 0.0,
      regularPrice: json['regular_price'] ?? 0.0,
      salePrice: json['sale_price'] ?? 0.0,
      stockQuantity: json['stock_quantity']  ?? 0,
      stockStatus: json['stock_status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'attributes': attributes.map((attr) => attr.toJson()).toList(),
      'image': image,
      'price': price,
      'regular_price': regularPrice,
      'sale_price': salePrice,
      'stock_quantity': stockQuantity,
      'stock_status': stockStatus,
    };
  }
}

class ProductAttribute {
  final String name;
  final String option;

  ProductAttribute({
    required this.name,
    required this.option,
  });

  factory ProductAttribute.fromJson(Map<String, dynamic> json) {
    return ProductAttribute(
      name: json['name'],
      option: json['option'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'option': option,
    };
  }
}
