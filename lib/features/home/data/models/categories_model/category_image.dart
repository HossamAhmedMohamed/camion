class CategoryImage {
  final int id;
  final String src;
  final String thumbnail;
  final String srcset;
  final String sizes;
  final String name;
  final String alt;

  CategoryImage({
    required this.id,
    required this.src,
    required this.thumbnail,
    required this.srcset,
    required this.sizes,
    required this.name,
    required this.alt,
  });

  factory CategoryImage.fromJson(Map<String, dynamic> json) {
    return CategoryImage(
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