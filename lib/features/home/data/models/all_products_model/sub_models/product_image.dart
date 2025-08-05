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
}