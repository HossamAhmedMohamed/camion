// models/country_model.dart
class CountryModel {
  final String name;
  final String code;
  final String dialCode;
  final String flag;

  const CountryModel({
    required this.name,
    required this.code,
    required this.dialCode,
    required this.flag,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryModel &&
          runtimeType == other.runtimeType &&
          code == other.code;

  @override
  int get hashCode => code.hashCode;
}

// data/countries_data.dart
class CountriesData {
  static const List<CountryModel> countries = [
    CountryModel(name: 'Egypt', code: 'EG', dialCode: '+20', flag: '🇪🇬'),
    CountryModel(
      name: 'Saudi Arabia',
      code: 'SA',
      dialCode: '+966',
      flag: '🇸🇦',
    ),
    CountryModel(
      name: 'United Arab Emirates',
      code: 'AE',
      dialCode: '+971',
      flag: '🇦🇪',
    ),
    CountryModel(name: 'Kuwait', code: 'KW', dialCode: '+965', flag: '🇰🇼'),
    CountryModel(name: 'Qatar', code: 'QA', dialCode: '+974', flag: '🇶🇦'),
    CountryModel(name: 'Bahrain', code: 'BH', dialCode: '+973', flag: '🇧🇭'),
    CountryModel(name: 'Oman', code: 'OM', dialCode: '+968', flag: '🇴🇲'),
    CountryModel(name: 'Jordan', code: 'JO', dialCode: '+962', flag: '🇯🇴'),
    CountryModel(name: 'Lebanon', code: 'LB', dialCode: '+961', flag: '🇱🇧'),
    CountryModel(name: 'Iraq', code: 'IQ', dialCode: '+964', flag: '🇮🇶'),
    CountryModel(name: 'Syria', code: 'SY', dialCode: '+963', flag: '🇸🇾'),
    CountryModel(name: 'Yemen', code: 'YE', dialCode: '+967', flag: '🇾🇪'),
    CountryModel(name: 'Palestine', code: 'PS', dialCode: '+970', flag: '🇵🇸'),
    CountryModel(name: 'Sudan', code: 'SD', dialCode: '+249', flag: '🇸🇩'),
    CountryModel(name: 'Libya', code: 'LY', dialCode: '+218', flag: '🇱🇾'),
    CountryModel(name: 'Tunisia', code: 'TN', dialCode: '+216', flag: '🇹🇳'),
    CountryModel(name: 'Algeria', code: 'DZ', dialCode: '+213', flag: '🇩🇿'),
    CountryModel(name: 'Morocco', code: 'MA', dialCode: '+212', flag: '🇲🇦'),
    CountryModel(
      name: 'Mauritania',
      code: 'MR',
      dialCode: '+222',
      flag: '🇲🇷',
    ),
    CountryModel(name: 'Turkey', code: 'TR', dialCode: '+90', flag: '🇹🇷'),
    CountryModel(name: 'Iran', code: 'IR', dialCode: '+98', flag: '🇮🇷'),
    CountryModel(name: 'India', code: 'IN', dialCode: '+91', flag: '🇮🇳'),
    CountryModel(name: 'China', code: 'CN', dialCode: '+86', flag: '🇨🇳'),
    CountryModel(name: 'Japan', code: 'JP', dialCode: '+81', flag: '🇯🇵'),
    CountryModel(
      name: 'South Korea',
      code: 'KR',
      dialCode: '+82',
      flag: '🇰🇷',
    ),
    CountryModel(name: 'Pakistan', code: 'PK', dialCode: '+92', flag: '🇵🇰'),
    CountryModel(name: 'Indonesia', code: 'ID', dialCode: '+62', flag: '🇮🇩'),
    CountryModel(name: 'Malaysia', code: 'MY', dialCode: '+60', flag: '🇲🇾'),
    CountryModel(name: 'Thailand', code: 'TH', dialCode: '+66', flag: '🇹🇭'),
    CountryModel(
      name: 'South Africa',
      code: 'ZA',
      dialCode: '+27',
      flag: '🇿🇦',
    ),
    CountryModel(name: 'Nigeria', code: 'NG', dialCode: '+234', flag: '🇳🇬'),
    CountryModel(name: 'Ethiopia', code: 'ET', dialCode: '+251', flag: '🇪🇹'),
    CountryModel(name: 'Kenya', code: 'KE', dialCode: '+254', flag: '🇰🇪'),

    CountryModel(
      name: 'United Kingdom',
      code: 'GB',
      dialCode: '+44',
      flag: '🇬🇧',
    ),
    CountryModel(name: 'France', code: 'FR', dialCode: '+33', flag: '🇫🇷'),
    CountryModel(name: 'Germany', code: 'DE', dialCode: '+49', flag: '🇩🇪'),
    CountryModel(name: 'Italy', code: 'IT', dialCode: '+39', flag: '🇮🇹'),
    CountryModel(name: 'Spain', code: 'ES', dialCode: '+34', flag: '🇪🇸'),
    CountryModel(name: 'Portugal', code: 'PT', dialCode: '+351', flag: '🇵🇹'),
    CountryModel(
      name: 'Netherlands',
      code: 'NL',
      dialCode: '+31',
      flag: '🇳🇱',
    ),
    CountryModel(name: 'Belgium', code: 'BE', dialCode: '+32', flag: '🇧🇪'),
    CountryModel(name: 'Austria', code: 'AT', dialCode: '+43', flag: '🇦🇹'),
    CountryModel(
      name: 'Switzerland',
      code: 'CH',
      dialCode: '+41',
      flag: '🇨🇭',
    ),
    CountryModel(name: 'Sweden', code: 'SE', dialCode: '+46', flag: '🇸🇪'),
    CountryModel(name: 'Norway', code: 'NO', dialCode: '+47', flag: '🇳🇴'),
    CountryModel(name: 'Denmark', code: 'DK', dialCode: '+45', flag: '🇩🇰'),
    CountryModel(name: 'Finland', code: 'FI', dialCode: '+358', flag: '🇫🇮'),
    CountryModel(name: 'Iceland', code: 'IS', dialCode: '+354', flag: '🇮🇸'),
    CountryModel(name: 'Greece', code: 'GR', dialCode: '+30', flag: '🇬🇷'),
    CountryModel(name: 'Poland', code: 'PL', dialCode: '+48', flag: '🇵🇱'),
    CountryModel(
      name: 'Czech Republic',
      code: 'CZ',
      dialCode: '+420',
      flag: '🇨🇿',
    ),
    CountryModel(name: 'Slovakia', code: 'SK', dialCode: '+421', flag: '🇸🇰'),
    CountryModel(name: 'Hungary', code: 'HU', dialCode: '+36', flag: '🇭🇺'),
    CountryModel(name: 'Romania', code: 'RO', dialCode: '+40', flag: '🇷🇴'),
    CountryModel(name: 'Bulgaria', code: 'BG', dialCode: '+359', flag: '🇧🇬'),
    CountryModel(name: 'Croatia', code: 'HR', dialCode: '+385', flag: '🇭🇷'),
    CountryModel(name: 'Serbia', code: 'RS', dialCode: '+381', flag: '🇷🇸'),
    CountryModel(
      name: 'Bosnia and Herzegovina',
      code: 'BA',
      dialCode: '+387',
      flag: '🇧🇦',
    ),
    CountryModel(
      name: 'Montenegro',
      code: 'ME',
      dialCode: '+382',
      flag: '🇲🇪',
    ),
    CountryModel(name: 'Albania', code: 'AL', dialCode: '+355', flag: '🇦🇱'),
    CountryModel(name: 'Estonia', code: 'EE', dialCode: '+372', flag: '🇪🇪'),
    CountryModel(name: 'Latvia', code: 'LV', dialCode: '+371', flag: '🇱🇻'),
    CountryModel(name: 'Lithuania', code: 'LT', dialCode: '+370', flag: '🇱🇹'),
    CountryModel(name: 'Ukraine', code: 'UA', dialCode: '+380', flag: '🇺🇦'),
    CountryModel(name: 'Russia', code: 'RU', dialCode: '+7', flag: '🇷🇺'),
    CountryModel(name: 'Belarus', code: 'BY', dialCode: '+375', flag: '🇧🇾'),
    CountryModel(name: 'Moldova', code: 'MD', dialCode: '+373', flag: '🇲🇩'),
    CountryModel(name: 'Ireland', code: 'IE', dialCode: '+353', flag: '🇮🇪'),
    CountryModel(
      name: 'Liechtenstein',
      code: 'LI',
      dialCode: '+423',
      flag: '🇱🇮',
    ),
    CountryModel(
      name: 'San Marino',
      code: 'SM',
      dialCode: '+378',
      flag: '🇸🇲',
    ),
    CountryModel(name: 'Andorra', code: 'AD', dialCode: '+376', flag: '🇦🇩'),
    CountryModel(name: 'Monaco', code: 'MC', dialCode: '+377', flag: '🇲🇨'),
    CountryModel(
      name: 'Vatican City',
      code: 'VA',
      dialCode: '+379',
      flag: '🇻🇦',
    ),

    CountryModel(
      name: 'United States',
      code: 'US',
      dialCode: '+1',
      flag: '🇺🇸',
    ),
    CountryModel(name: 'Canada', code: 'CA', dialCode: '+1', flag: '🇨🇦'),
    CountryModel(name: 'Mexico', code: 'MX', dialCode: '+52', flag: '🇲🇽'),

    CountryModel(name: 'Brazil', code: 'BR', dialCode: '+55', flag: '🇧🇷'),
    CountryModel(name: 'Argentina', code: 'AR', dialCode: '+54', flag: '🇦🇷'),
    CountryModel(name: 'Chile', code: 'CL', dialCode: '+56', flag: '🇨🇱'),
    CountryModel(name: 'Colombia', code: 'CO', dialCode: '+57', flag: '🇨🇴'),
    CountryModel(name: 'Australia', code: 'AU', dialCode: '+61', flag: '🇦🇺'),
    CountryModel(
      name: 'New Zealand',
      code: 'NZ',
      dialCode: '+64',
      flag: '🇳🇿',
    ),

    // يمكنك إضافة المزيد من الدول
  ];

  static CountryModel getDefaultCountry() {
    return countries.first; // مصر كافتراضي
  }

  static CountryModel? getCountryByCode(String code) {
    try {
      return countries.firstWhere((country) => country.code == code);
    } catch (e) {
      return null;
    }
  }

  static CountryModel? getCountryByDialCode(String dialCode) {
    try {
      return countries.firstWhere((country) => country.dialCode == dialCode);
    } catch (e) {
      return null;
    }
  }
}
