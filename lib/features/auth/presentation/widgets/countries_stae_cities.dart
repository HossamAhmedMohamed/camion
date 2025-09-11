// country_state_city_widget.dart
import 'dart:developer';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/features/auth/data/models/countries_model/shipping/shipping_countries_model.dart';
import 'package:camion/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:country_state_city/country_state_city.dart' as csc;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountryStateCityWidget extends StatefulWidget {
  final TextEditingController countryController;
  final TextEditingController stateController;
  final TextEditingController cityController;

  const CountryStateCityWidget({
    super.key,
    required this.countryController,
    required this.stateController,
    required this.cityController,
  });

  @override
  State<CountryStateCityWidget> createState() => _CountryStateCityWidgetState();
}

class _CountryStateCityWidgetState extends State<CountryStateCityWidget> {
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;

  List<csc.Country> availableCountries = [];
  List<csc.State> states = [];
  List<csc.City> cities = [];

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  void _loadCountries() async {
    List<csc.Country> allCountries = await csc.getAllCountries();

    availableCountries = allCountries.where((country) {
      return countries.contains(country.isoCode);
    }).toList();

    availableCountries.sort((a, b) => a.name.compareTo(b.name));

    setState(() {});
  }

  void _loadStates(String countryCode) async {
    states = await csc.getStatesOfCountry(countryCode);
    cities = [];
    selectedState = null;
    selectedCity = null;
    widget.stateController.clear();
    widget.cityController.clear();
    setState(() {});
  }

  void _loadCities(String countryCode, String stateCode) async {
    cities = await csc.getStateCities(countryCode, stateCode);
    selectedCity = null;
    widget.cityController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Country Dropdown
        DropdownButtonFormField<String>(
          icon: const Icon(Icons.keyboard_arrow_down),
          value: selectedCountry,
          decoration: InputDecoration(
            hintText: S.of(context).country,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.w),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 2.w),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.red, width: 1.w),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.red, width: 2.w),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 16.h,
            ),
          ),
          isExpanded: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return S.of(context).please_select_your_country;
            }
            return null;
          },
          onChanged: (value) {
            setState(() {
              selectedCountry = value;
              // widget.countryController.text = availableCountries
              //     .firstWhere((c) => c.isoCode == value)
              //     .name;
              widget.countryController.text = value!;

              log(widget.countryController.text);
            });
            if (value != null) {
              _loadStates(value);
            }
          },
          items: availableCountries.map((country) {
            return DropdownMenuItem(
              value: country.isoCode,
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 24,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        country.flag,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(country.name, overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            );
          }).toList(),
        ),

        SizedBox(height: 10.h),

        // State Dropdown
        DropdownButtonFormField<String>(
          icon: const Icon(Icons.keyboard_arrow_down),
          value: selectedState,
          decoration: InputDecoration(
            hintText: S.of(context).state,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.w),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 2.w),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.red, width: 1.w),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.red, width: 2.w),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 16.h,
            ),
          ),
          isExpanded: true,
          validator: (value) {
            if (selectedCountry != null && (value == null || value.isEmpty)) {
              return S.of(context).please_enter_your_state;
            }
            return null;
          },
          onChanged: selectedCountry == null
              ? null
              : (value) {
                  setState(() {
                    selectedState = value;
                    // widget.stateController.text = states
                    //     .firstWhere((s) => s.isoCode == value)
                    //     .name;

                    widget.stateController.text = value!;

                    log(widget.stateController.text);
                  });
                  if (value != null && selectedCountry != null) {
                    _loadCities(selectedCountry!, value);
                  }
                },
          items: states.map((state) {
            return DropdownMenuItem(
              value: state.isoCode,
              child: Text(state.name, overflow: TextOverflow.ellipsis),
            );
          }).toList(),
        ),

        SizedBox(height: 10.h),

        // City Dropdown
        DropdownButtonFormField<String>(
          icon: const Icon(Icons.keyboard_arrow_down),
          value: selectedCity,
          decoration: InputDecoration(
            hintText: S.of(context).city,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.w),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 2.w),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.red, width: 1.w),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.red, width: 2.w),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 16.h,
            ),
          ),
          isExpanded: true,
          validator: (value) {
            if (selectedState != null && (value == null || value.isEmpty)) {
              return S.of(context).please_enter_your_city;
            }
            return null;
          },
          onChanged: selectedState == null
              ? null
              : (value) {
                  setState(() {
                    selectedCity = value;
                    widget.cityController.text = value!;
                  });
                },
          items: cities.map((city) {
            return DropdownMenuItem(
              value: city.name,
              child: Text(city.name, overflow: TextOverflow.ellipsis),
            );
          }).toList(),
        ),
      ],
    );
  }
}
