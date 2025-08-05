class AddToCart {
  final String text;
  final String description;
  final String url;
  final String singleText;
  final int minimum;
  final int maximum;
  final int multipleOf;

  AddToCart({
    required this.text,
    required this.description,
    required this.url,
    required this.singleText,
    required this.minimum,
    required this.maximum,
    required this.multipleOf,
  });

  factory AddToCart.fromJson(Map<String, dynamic> json) {
    return AddToCart(
      text: json['text'],
      description: json['description'],
      url: json['url'],
      singleText: json['single_text'],
      minimum: json['minimum'],
      maximum: json['maximum'],
      multipleOf: json['multiple_of'],
    );
  }
}