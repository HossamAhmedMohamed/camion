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


  static const List<CountryModel> countriesArabic = [
  CountryModel(name: 'مصر', code: 'EG', dialCode: '+20', flag: '🇪🇬'),
  CountryModel(name: 'المملكة العربية السعودية', code: 'SA', dialCode: '+966', flag: '🇸🇦'),
  CountryModel(name: 'الإمارات العربية المتحدة', code: 'AE', dialCode: '+971', flag: '🇦🇪'),
  CountryModel(name: 'الكويت', code: 'KW', dialCode: '+965', flag: '🇰🇼'),
  CountryModel(name: 'قطر', code: 'QA', dialCode: '+974', flag: '🇶🇦'),
  CountryModel(name: 'البحرين', code: 'BH', dialCode: '+973', flag: '🇧🇭'),
  CountryModel(name: 'عُمان', code: 'OM', dialCode: '+968', flag: '🇴🇲'),
  CountryModel(name: 'الأردن', code: 'JO', dialCode: '+962', flag: '🇯🇴'),
  CountryModel(name: 'لبنان', code: 'LB', dialCode: '+961', flag: '🇱🇧'),
  CountryModel(name: 'العراق', code: 'IQ', dialCode: '+964', flag: '🇮🇶'),
  CountryModel(name: 'سوريا', code: 'SY', dialCode: '+963', flag: '🇸🇾'),
  CountryModel(name: 'اليمن', code: 'YE', dialCode: '+967', flag: '🇾🇪'),
  CountryModel(name: 'فلسطين', code: 'PS', dialCode: '+970', flag: '🇵🇸'),
  CountryModel(name: 'السودان', code: 'SD', dialCode: '+249', flag: '🇸🇩'),
  CountryModel(name: 'ليبيا', code: 'LY', dialCode: '+218', flag: '🇱🇾'),
  CountryModel(name: 'تونس', code: 'TN', dialCode: '+216', flag: '🇹🇳'),
  CountryModel(name: 'الجزائر', code: 'DZ', dialCode: '+213', flag: '🇩🇿'),
  CountryModel(name: 'المغرب', code: 'MA', dialCode: '+212', flag: '🇲🇦'),
  CountryModel(name: 'موريتانيا', code: 'MR', dialCode: '+222', flag: '🇲🇷'),
  CountryModel(name: 'تركيا', code: 'TR', dialCode: '+90', flag: '🇹🇷'),
  CountryModel(name: 'إيران', code: 'IR', dialCode: '+98', flag: '🇮🇷'),
  CountryModel(name: 'الهند', code: 'IN', dialCode: '+91', flag: '🇮🇳'),
  CountryModel(name: 'الصين', code: 'CN', dialCode: '+86', flag: '🇨🇳'),
  CountryModel(name: 'اليابان', code: 'JP', dialCode: '+81', flag: '🇯🇵'),
  CountryModel(name: 'كوريا الجنوبية', code: 'KR', dialCode: '+82', flag: '🇰🇷'),
  CountryModel(name: 'باكستان', code: 'PK', dialCode: '+92', flag: '🇵🇰'),
  CountryModel(name: 'إندونيسيا', code: 'ID', dialCode: '+62', flag: '🇮🇩'),
  CountryModel(name: 'ماليزيا', code: 'MY', dialCode: '+60', flag: '🇲🇾'),
  CountryModel(name: 'تايلاند', code: 'TH', dialCode: '+66', flag: '🇹🇭'),
  CountryModel(name: 'جنوب أفريقيا', code: 'ZA', dialCode: '+27', flag: '🇿🇦'),
  CountryModel(name: 'نيجيريا', code: 'NG', dialCode: '+234', flag: '🇳🇬'),
  CountryModel(name: 'إثيوبيا', code: 'ET', dialCode: '+251', flag: '🇪🇹'),
  CountryModel(name: 'كينيا', code: 'KE', dialCode: '+254', flag: '🇰🇪'),

  CountryModel(name: 'المملكة المتحدة', code: 'GB', dialCode: '+44', flag: '🇬🇧'),
  CountryModel(name: 'فرنسا', code: 'FR', dialCode: '+33', flag: '🇫🇷'),
  CountryModel(name: 'ألمانيا', code: 'DE', dialCode: '+49', flag: '🇩🇪'),
  CountryModel(name: 'إيطاليا', code: 'IT', dialCode: '+39', flag: '🇮🇹'),
  CountryModel(name: 'إسبانيا', code: 'ES', dialCode: '+34', flag: '🇪🇸'),
  CountryModel(name: 'البرتغال', code: 'PT', dialCode: '+351', flag: '🇵🇹'),
  CountryModel(name: 'هولندا', code: 'NL', dialCode: '+31', flag: '🇳🇱'),
  CountryModel(name: 'بلجيكا', code: 'BE', dialCode: '+32', flag: '🇧🇪'),
  CountryModel(name: 'النمسا', code: 'AT', dialCode: '+43', flag: '🇦🇹'),
  CountryModel(name: 'سويسرا', code: 'CH', dialCode: '+41', flag: '🇨🇭'),
  CountryModel(name: 'السويد', code: 'SE', dialCode: '+46', flag: '🇸🇪'),
  CountryModel(name: 'النرويج', code: 'NO', dialCode: '+47', flag: '🇳🇴'),
  CountryModel(name: 'الدنمارك', code: 'DK', dialCode: '+45', flag: '🇩🇰'),
  CountryModel(name: 'فنلندا', code: 'FI', dialCode: '+358', flag: '🇫🇮'),
  CountryModel(name: 'آيسلندا', code: 'IS', dialCode: '+354', flag: '🇮🇸'),
  CountryModel(name: 'اليونان', code: 'GR', dialCode: '+30', flag: '🇬🇷'),
  CountryModel(name: 'بولندا', code: 'PL', dialCode: '+48', flag: '🇵🇱'),
  CountryModel(name: 'جمهورية التشيك', code: 'CZ', dialCode: '+420', flag: '🇨🇿'),
  CountryModel(name: 'سلوفاكيا', code: 'SK', dialCode: '+421', flag: '🇸🇰'),
  CountryModel(name: 'المجر', code: 'HU', dialCode: '+36', flag: '🇭🇺'),
  CountryModel(name: 'رومانيا', code: 'RO', dialCode: '+40', flag: '🇷🇴'),
  CountryModel(name: 'بلغاريا', code: 'BG', dialCode: '+359', flag: '🇧🇬'),
  CountryModel(name: 'كرواتيا', code: 'HR', dialCode: '+385', flag: '🇭🇷'),
  CountryModel(name: 'صربيا', code: 'RS', dialCode: '+381', flag: '🇷🇸'),
  CountryModel(name: 'البوسنة والهرسك', code: 'BA', dialCode: '+387', flag: '🇧🇦'),
  CountryModel(name: 'الجبل الأسود', code: 'ME', dialCode: '+382', flag: '🇲🇪'),
  CountryModel(name: 'ألبانيا', code: 'AL', dialCode: '+355', flag: '🇦🇱'),
  CountryModel(name: 'إستونيا', code: 'EE', dialCode: '+372', flag: '🇪🇪'),
  CountryModel(name: 'لاتفيا', code: 'LV', dialCode: '+371', flag: '🇱🇻'),
  CountryModel(name: 'ليتوانيا', code: 'LT', dialCode: '+370', flag: '🇱🇹'),
  CountryModel(name: 'أوكرانيا', code: 'UA', dialCode: '+380', flag: '🇺🇦'),
  CountryModel(name: 'روسيا', code: 'RU', dialCode: '+7', flag: '🇷🇺'),
  CountryModel(name: 'بيلاروسيا', code: 'BY', dialCode: '+375', flag: '🇧🇾'),
  CountryModel(name: 'مولدوفا', code: 'MD', dialCode: '+373', flag: '🇲🇩'),
  CountryModel(name: 'إيرلندا', code: 'IE', dialCode: '+353', flag: '🇮🇪'),
  CountryModel(name: 'ليختنشتاين', code: 'LI', dialCode: '+423', flag: '🇱🇮'),
  CountryModel(name: 'سان مارينو', code: 'SM', dialCode: '+378', flag: '🇸🇲'),
  CountryModel(name: 'أندورا', code: 'AD', dialCode: '+376', flag: '🇦🇩'),
  CountryModel(name: 'موناكو', code: 'MC', dialCode: '+377', flag: '🇲🇨'),
  CountryModel(name: 'الفاتيكان', code: 'VA', dialCode: '+379', flag: '🇻🇦'),

  CountryModel(name: 'الولايات المتحدة الأمريكية', code: 'US', dialCode: '+1', flag: '🇺🇸'),
  CountryModel(name: 'كندا', code: 'CA', dialCode: '+1', flag: '🇨🇦'),
  CountryModel(name: 'المكسيك', code: 'MX', dialCode: '+52', flag: '🇲🇽'),

  CountryModel(name: 'البرازيل', code: 'BR', dialCode: '+55', flag: '🇧🇷'),
  CountryModel(name: 'الأرجنتين', code: 'AR', dialCode: '+54', flag: '🇦🇷'),
  CountryModel(name: 'تشيلي', code: 'CL', dialCode: '+56', flag: '🇨🇱'),
  CountryModel(name: 'كولومبيا', code: 'CO', dialCode: '+57', flag: '🇨🇴'),
  CountryModel(name: 'أستراليا', code: 'AU', dialCode: '+61', flag: '🇦🇺'),
  CountryModel(name: 'نيوزيلندا', code: 'NZ', dialCode: '+64', flag: '🇳🇿'),
];



   static List<CountryModel> getAllCountries() {
    return countries;
  }

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
