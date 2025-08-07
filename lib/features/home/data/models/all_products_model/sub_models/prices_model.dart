

class Prices {
  final String price;
  final String regularPrice;
  final String salePrice;

  final String currencyCode;
  final String currencySymbol;
  final int currencyMinorUnit;
  final String currencyDecimalSeparator;
  final String currencyThousandSeparator;
  final String currencyPrefix;
  final String currencySuffix;

  Prices({
    required this.price,
    required this.regularPrice,
    required this.salePrice,

    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyMinorUnit,
    required this.currencyDecimalSeparator,
    required this.currencyThousandSeparator,
    required this.currencyPrefix,
    required this.currencySuffix,
  });

  factory Prices.fromJson(Map<String, dynamic> json) {
    return Prices(
      price:  json['price'],
      regularPrice: json['regular_price'],
      salePrice: json['sale_price'],

      currencyCode: json['currency_code'],
      currencySymbol: json['currency_symbol'],
      currencyMinorUnit: json['currency_minor_unit'],
      currencyDecimalSeparator: json['currency_decimal_separator'],
      currencyThousandSeparator: json['currency_thousand_separator'],
      currencyPrefix: json['currency_prefix'],
      currencySuffix: json['currency_suffix'],
    );
  }
}
