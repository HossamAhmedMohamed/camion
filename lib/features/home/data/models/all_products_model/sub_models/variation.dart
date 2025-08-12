class Variation {
  final String attribute;
  final String value;

  Variation({
    required this.attribute,
    required this.value,
  });

  factory Variation.fromJson(Map<String, dynamic> json) {
    return Variation(
      attribute: json['attribute'] ?? '',
      value: json['value'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attribute': attribute,
      'value': value,
    };
  }
}
