class Variation {
  final int id;
  final List<dynamic> attributes;

  Variation({required this.id, required this.attributes});

  factory Variation.fromJson(Map<String, dynamic> json) {
    return Variation(
      id: json['id'],
      attributes: json['attributes'] ?? [],
    );
  }
}