class PriceRange {
  final String minAmount;
  final String maxAmount;

  PriceRange({required this.minAmount, required this.maxAmount});

  factory PriceRange.fromJson(Map<String, dynamic> json) {
    return PriceRange(
      minAmount: json['min_amount'],
      maxAmount: json['max_amount'],
    );
  }
}