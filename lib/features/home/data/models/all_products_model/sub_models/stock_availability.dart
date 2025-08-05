class StockAvailability {
  final String text;
  final String className;

  StockAvailability({required this.text, required this.className});

  factory StockAvailability.fromJson(Map<String, dynamic> json) {
    return StockAvailability(
      text: json['text'] ?? '',
      className: json['class'] ?? '',
    );
  }
}