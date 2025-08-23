class ReviewModel {
  final int id;
  final DateTime dateCreated;
  final String formattedDateCreated;
  final String dateCreatedGmt;
  final int productId;
  final String productName;
  final String productPermalink;
  final ProductImage productImage;
  final String reviewer;
  final String review;
  final int rating;
  final bool verified;
  final Map<String, String> reviewerAvatarUrls;

  ReviewModel({
    required this.id,
    required this.dateCreated,
    required this.formattedDateCreated,
    required this.dateCreatedGmt,
    required this.productId,
    required this.productName,
    required this.productPermalink,
    required this.productImage,
    required this.reviewer,
    required this.review,
    required this.rating,
    required this.verified,
    required this.reviewerAvatarUrls,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      dateCreated: DateTime.parse(json['date_created']),
      formattedDateCreated: json['formatted_date_created'],
      dateCreatedGmt: json['date_created_gmt'],
      productId: json['product_id'],
      productName: json['product_name'],
      productPermalink: json['product_permalink'],
      productImage: ProductImage.fromJson(json['product_image']),
      reviewer: json['reviewer'],
      review: json['review'],
      rating: json['rating'],
      verified: json['verified'],
      reviewerAvatarUrls: Map<String, String>.from(
        json['reviewer_avatar_urls'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date_created': dateCreated,
      'formatted_date_created': formattedDateCreated,
      'date_created_gmt': dateCreatedGmt,
      'product_id': productId,
      'product_name': productName,
      'product_permalink': productPermalink,
      'product_image': productImage.toJson(),
      'reviewer': reviewer,
      'review': review,
      'rating': rating,
      'verified': verified,
      'reviewer_avatar_urls': reviewerAvatarUrls,
    };
  }
}

class ProductImage {
  final int id;
  final String src;
  final String thumbnail;
  final String srcset;
  final String sizes;
  final String name;
  final String alt;

  ProductImage({
    required this.id,
    required this.src,
    required this.thumbnail,
    required this.srcset,
    required this.sizes,
    required this.name,
    required this.alt,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'],
      src: json['src'],
      thumbnail: json['thumbnail'],
      srcset: json['srcset'],
      sizes: json['sizes'],
      name: json['name'],
      alt: json['alt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'src': src,
      'thumbnail': thumbnail,
      'srcset': srcset,
      'sizes': sizes,
      'name': name,
      'alt': alt,
    };
  }
}
