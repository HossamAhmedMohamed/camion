// controllers/phone_number_controller.dart
import 'package:camion/features/auth/data/models/countries_model/country_model.dart';
import 'package:flutter/material.dart';

class PhoneNumberController extends ChangeNotifier {
  CountryModel _selectedCountry = CountriesData.getDefaultCountry();
  final TextEditingController _phoneController = TextEditingController();

  CountryModel get selectedCountry => _selectedCountry;
  TextEditingController get phoneController => _phoneController;
  
  String get fullPhoneNumber => '${_selectedCountry.dialCode}${_phoneController.text}';
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