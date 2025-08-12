class Attribute {
  final int id;
  final String name;
  final String taxonomy;
  final bool hasVariations;
  final List<AttributeTerm> terms;

  Attribute({
    required this.id,
    required this.name,
    required this.taxonomy,
    required this.hasVariations,
    required this.terms,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) {
    return Attribute(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      taxonomy: json['taxonomy'] ?? '',
      hasVariations: json['has_variations'] ?? false,
      terms: (json['terms'] as List? ?? [])
          .map((t) => AttributeTerm.fromJson(t))
          .toList(),
    );
  }
}

class AttributeTerm {
  final int id;
  final String name;
  final String slug;

  AttributeTerm({required this.id, required this.name, required this.slug});

  factory AttributeTerm.fromJson(Map<String, dynamic> json) {
    return AttributeTerm(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
    );
  }
}
