// controllers/phone_number_controller.dart
import 'package:camion/features/auth/data/models/countries_model/country_model.dart';
import 'package:flutter/material.dart';

class PhoneNumberController extends ChangeNotifier {
  CountryModel _selectedCountry = CountriesData.getDefaultCountry();
  final TextEditingController _phoneController = TextEditingController();

  CountryModel get selectedCountry => _selectedCountry;
  TextEditingController get phoneController => _phoneController;

  String get fullPhoneNumber =>
      '${_selectedCountry.dialCode}${_phoneController.text}';
  String get phoneNumber => _phoneController.text;
  String get countryCode => _selectedCountry.dialCode;

  void setCountry(CountryModel country) {
    _selectedCountry = country;
    notifyListeners();
  }

  void setPhoneNumber(String phoneNumber) {
    _phoneController.text = phoneNumber;
    notifyListeners();
  }

  // دالة لتعيين الرقم مع كود الدولة
  void setPhoneWithCountryCode(String phone, String? countryCode) {
    if (phone.isEmpty) {
      clear();
      return;
    }

    // البحث عن الدولة بناءً على country code أولاً
    CountryModel? country;
    if (countryCode != null && countryCode.isNotEmpty) {
      country = CountriesData.getCountryByCode(countryCode);
    }

    // إذا لم نجد الدولة، حاول استخراجها من رقم الهاتف
    if (country == null) {
      country = _findCountryByDialCode(phone);
    }

    // تعيين الدولة
    if (country != null) {
      _selectedCountry = country;

      // تنظيف رقم الهاتف
      String cleanPhone = phone.trim().replaceAll(RegExp(r'[\s\-\(\)]'), '');

      // إزالة علامة + إذا كانت موجودة
      if (cleanPhone.startsWith('+')) {
        cleanPhone = cleanPhone.substring(1);
      }

      // إزالة كود الدولة من الرقم
      String countryDialCode = country.dialCode.substring(1); // إزالة +
      if (cleanPhone.startsWith(countryDialCode)) {
        cleanPhone = cleanPhone.substring(countryDialCode.length);
        // إزالة التكرار في كود الدولة إذا وُجد
        cleanPhone = _removeDuplicateCountryCode(cleanPhone, country.dialCode);
      }

      _phoneController.text = cleanPhone;
    } else {
      // استخدام الدولة الافتراضية
      _selectedCountry = CountriesData.getDefaultCountry();
      String cleanPhone = phone.replaceAll(RegExp(r'[\s\-\(\)\+]'), '');
      _phoneController.text = cleanPhone;
    }

    notifyListeners();
  }

  // setter للرقم الكامل
  set fullPhoneNumber(String fullPhone) {
    if (fullPhone.isEmpty) {
      clear();
      return;
    }

    // تنظيف الرقم
    String cleanPhone = fullPhone.trim().replaceAll(RegExp(r'[\s\-\(\)]'), '');

    // التأكد من وجود + في البداية
    if (!cleanPhone.startsWith('+')) {
      cleanPhone = '+$cleanPhone';
    }

    // البحث عن كود الدولة المناسب
    final country = _findCountryByDialCode(cleanPhone);
    if (country != null) {
      _selectedCountry = country;
      String phoneWithoutCode = cleanPhone.substring(country.dialCode.length);

      // إزالة التكرار في كود الدولة
      phoneWithoutCode = _removeDuplicateCountryCode(phoneWithoutCode, country.dialCode);

      _phoneController.text = phoneWithoutCode;
    } else {
      // إذا لم يتم العثور على كود الدولة
      _phoneController.text = cleanPhone.startsWith('+') ? cleanPhone.substring(1) : cleanPhone;
      _selectedCountry = CountriesData.getDefaultCountry();
    }
    notifyListeners();
  }

  // دالة لإزالة التكرار في كود الدولة
  String _removeDuplicateCountryCode(String phoneNumber, String dialCode) {
    // إزالة الـ + من كود الدولة للمقارنة
    String codeWithoutPlus = dialCode.substring(1);

    // إذا كان رقم الهاتف يبدأ بنفس كود الدولة، أزله
    if (phoneNumber.startsWith(codeWithoutPlus)) {
      return phoneNumber.substring(codeWithoutPlus.length);
    }

    return phoneNumber;
  }

  // دالة للبحث عن الدولة بناءً على كود الاتصال
  CountryModel? _findCountryByDialCode(String fullPhone) {
    try {
      final countries = List<CountryModel>.from(CountriesData.countries);

      if (countries.isEmpty) return null;

      // ترتيب البلدان حسب طول كود الاتصال (الأطول أولاً) لتجنب التداخل
      countries.sort((a, b) => b.dialCode.length.compareTo(a.dialCode.length));

      // تنظيف الرقم
      String cleanPhone = fullPhone.trim();
      if (!cleanPhone.startsWith('+')) {
        cleanPhone = '+$cleanPhone';
      }

      for (final country in countries) {
        if (cleanPhone.startsWith(country.dialCode)) {
          return country;
        }
      }
      return null;
    } catch (e) {
      // في حالة حدوث خطأ، إرجاع null
      print('Error finding country by dial code: $e');
      return null;
    }
  }

  // دالة للتحقق من صحة الرقم
  bool get isValidPhoneNumber {
    final phoneText = _phoneController.text.trim();
    return phoneText.isNotEmpty &&
           phoneText.length >= 7 &&
           phoneText.length <= 15 &&
           RegExp(r'^[0-9]+$').hasMatch(phoneText);
  }

  // دالة للحصول على الرقم المنسق
  String get formattedPhoneNumber {
    if (_phoneController.text.isEmpty) return '';
    return '${_selectedCountry.dialCode} ${_phoneController.text}';
  }

  void clear() {
    _phoneController.clear();
    _selectedCountry = CountriesData.getDefaultCountry();
    notifyListeners();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}