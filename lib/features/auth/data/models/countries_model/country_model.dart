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
    CountryModel(
      name: 'مصر',
      code: 'EG',
      dialCode: '+20',
      flag: '🇪🇬',
    ),
    CountryModel(
      name: 'السعودية',
      code: 'SA',
      dialCode: '+966',
      flag: '🇸🇦',
    ),
    CountryModel(
      name: 'الإمارات',
      code: 'AE',
      dialCode: '+971',
      flag: '🇦🇪',
    ),
    CountryModel(
      name: 'الكويت',
      code: 'KW',
      dialCode: '+965',
      flag: '🇰🇼',
    ),
    CountryModel(
      name: 'قطر',
      code: 'QA',
      dialCode: '+974',
      flag: '🇶🇦',
    ),
    CountryModel(
      name: 'البحرين',
      code: 'BH',
      dialCode: '+973',
      flag: '🇧🇭',
    ),
    CountryModel(
      name: 'عُمان',
      code: 'OM',
      dialCode: '+968',
      flag: '🇴🇲',
    ),
    CountryModel(
      name: 'الأردن',
      code: 'JO',
      dialCode: '+962',
      flag: '🇯🇴',
    ),
    CountryModel(
      name: 'لبنان',
      code: 'LB',
      dialCode: '+961',
      flag: '🇱🇧',
    ),
    CountryModel(
      name: 'العراق',
      code: 'IQ',
      dialCode: '+964',
      flag: '🇮🇶',
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