class SliderItemModel {
  final int id;
  final String imageUrl;
  final String title;
  final String description;
  final String discount;

  SliderItemModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.discount,
  });

  factory SliderItemModel.fromJson(Map<String, dynamic> json) {
    return SliderItemModel(
      id: json['id'] ?? 0,
      imageUrl: json['imageUrl']?.trim() ?? '',
      title: json['title']?.trim() ?? '',
      description: json['description']?.trim() ?? '',
      discount: json['discount']?.toString().trim() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'description': description,
      'discount': discount,
    };
  }
}
