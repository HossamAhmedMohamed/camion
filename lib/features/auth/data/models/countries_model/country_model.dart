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
    CountryModel(name: 'مصر', code: 'EG', dialCode: '+20', flag: '🇪🇬'),
    CountryModel(name: 'السعودية', code: 'SA', dialCode: '+966', flag: '🇸🇦'),
    CountryModel(name: 'الإمارات', code: 'AE', dialCode: '+971', flag: '🇦🇪'),
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
    CountryModel(
      name: 'كوريا الجنوبية',
      code: 'KR',
      dialCode: '+82',
      flag: '🇰🇷',
    ),
    CountryModel(name: 'باكستان', code: 'PK', dialCode: '+92', flag: '🇵🇰'),
    CountryModel(name: 'إندونيسيا', code: 'ID', dialCode: '+62', flag: '🇮🇩'),
    CountryModel(name: 'ماليزيا', code: 'MY', dialCode: '+60', flag: '🇲🇾'),
    CountryModel(name: 'تايلاند', code: 'TH', dialCode: '+66', flag: '🇹🇭'),
    CountryModel(
      name: 'جنوب أفريقيا',
      code: 'ZA',
      dialCode: '+27',
      flag: '🇿🇦',
    ),
    CountryModel(name: 'نيجيريا', code: 'NG', dialCode: '+234', flag: '🇳🇬'),
    CountryModel(name: 'إثيوبيا', code: 'ET', dialCode: '+251', flag: '🇪🇹'),
    CountryModel(name: 'كينيا', code: 'KE', dialCode: '+254', flag: '🇰🇪'),

    CountryModel(
      name: 'المملكة المتحدة',
      code: 'GB',
      dialCode: '+44',
      flag: '🇬🇧',
    ),
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
    CountryModel(name: 'أيسلندا', code: 'IS', dialCode: '+354', flag: '🇮🇸'),
    CountryModel(name: 'اليونان', code: 'GR', dialCode: '+30', flag: '🇬🇷'),
    CountryModel(name: 'تركيا', code: 'TR', dialCode: '+90', flag: '🇹🇷'),
    CountryModel(name: 'بولندا', code: 'PL', dialCode: '+48', flag: '🇵🇱'),
    CountryModel(name: 'التشيك', code: 'CZ', dialCode: '+420', flag: '🇨🇿'),
    CountryModel(name: 'سلوفاكيا', code: 'SK', dialCode: '+421', flag: '🇸🇰'),
    CountryModel(name: 'المجر', code: 'HU', dialCode: '+36', flag: '🇭🇺'),
    CountryModel(name: 'رومانيا', code: 'RO', dialCode: '+40', flag: '🇷🇴'),
    CountryModel(name: 'بلغاريا', code: 'BG', dialCode: '+359', flag: '🇧🇬'),
    CountryModel(name: 'كرواتيا', code: 'HR', dialCode: '+385', flag: '🇭🇷'),
    CountryModel(name: 'صربيا', code: 'RS', dialCode: '+381', flag: '🇷🇸'),
    CountryModel(
      name: 'البوسنة والهرسك',
      code: 'BA',
      dialCode: '+387',
      flag: '🇧🇦',
    ),
    CountryModel(
      name: 'مونتينيغرو',
      code: 'ME',
      dialCode: '+382',
      flag: '🇲🇪',
    ),
    CountryModel(name: 'ألبانيا', code: 'AL', dialCode: '+355', flag: '🇦🇱'),
    CountryModel(name: 'إستونيا', code: 'EE', dialCode: '+372', flag: '🇪🇪'),
    CountryModel(name: 'لاتفيا', code: 'LV', dialCode: '+371', flag: '🇱🇻'),
    CountryModel(name: 'ليتوانيا', code: 'LT', dialCode: '+370', flag: '🇱🇹'),
    CountryModel(name: 'أوكرانيا', code: 'UA', dialCode: '+380', flag: '🇺🇦'),
    CountryModel(name: 'روسيا', code: 'RU', dialCode: '+7', flag: '🇷🇺'),
    CountryModel(name: 'بيلاروسيا', code: 'BY', dialCode: '+375', flag: '🇧🇾'),
    CountryModel(name: 'مولدوفا', code: 'MD', dialCode: '+373', flag: '🇲🇩'),
    CountryModel(name: 'أيرلندا', code: 'IE', dialCode: '+353', flag: '🇮🇪'),
    CountryModel(
      name: 'ليختنشتاين',
      code: 'LI',
      dialCode: '+423',
      flag: '🇱🇮',
    ),
    CountryModel(
      name: 'سان مارينو',
      code: 'SM',
      dialCode: '+378',
      flag: '🇸🇲',
    ),
    CountryModel(name: 'أندورا', code: 'AD', dialCode: '+376', flag: '🇦🇩'),
    CountryModel(name: 'موناكو', code: 'MC', dialCode: '+377', flag: '🇲🇨'),
    CountryModel(name: 'الفاتيكان', code: 'VA', dialCode: '+379', flag: '🇻🇦'),

    CountryModel(
      name: 'الولايات المتحدة',
      code: 'US',
      dialCode: '+1',
      flag: '🇺🇸',
    ),
    CountryModel(name: 'كندا', code: 'CA', dialCode: '+1', flag: '🇨🇦'),
    CountryModel(name: 'المكسيك', code: 'MX', dialCode: '+52', flag: '🇲🇽'),

    // 🌍 أمريكا الجنوبية
    CountryModel(name: 'البرازيل', code: 'BR', dialCode: '+55', flag: '🇧🇷'),
    CountryModel(name: 'الأرجنتين', code: 'AR', dialCode: '+54', flag: '🇦🇷'),
    CountryModel(name: 'تشيلي', code: 'CL', dialCode: '+56', flag: '🇨🇱'),
    CountryModel(name: 'كولومبيا', code: 'CO', dialCode: '+57', flag: '🇨🇴'),
    CountryModel(name: 'أستراليا', code: 'AU', dialCode: '+61', flag: '🇦🇺'),
    CountryModel(name: 'نيوزيلندا', code: 'NZ', dialCode: '+64', flag: '🇳🇿'),
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
