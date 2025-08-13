import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/config/widgets/custom_text_form_field.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

// إنشاء model للبيانات
class AddressData {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String address1;
  final String address2;
  final String city;
  final String state;
  final String postcode;
  final String country;
  final String shippingFirstName;
  final String shippingLastName;
  final String shippingAddress1;
  final String shippingAddress2;
  final String shippingCity;
  final String shippingState;
  final String shippingPostcode;
  final String shippingCountry;

  AddressData({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
    required this.shippingFirstName,
    required this.shippingLastName,
    required this.shippingAddress1,
    required this.shippingAddress2,
    required this.shippingCity,
    required this.shippingState,
    required this.shippingPostcode,
    required this.shippingCountry,
  });
}

// Service للتعامل مع الاقتراحات التلقائية
class AutoCompleteService {
  static const String _prefix = 'autocomplete_';

  // حفظ اقتراح جديد لحقل معين
  static Future<void> saveSuggestion(String fieldKey, String value) async {
    if (value.trim().isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    List<String> suggestions = prefs.getStringList('$_prefix$fieldKey') ?? [];

    // إضافة القيمة الجديدة في المقدمة إذا لم تكن موجودة
    if (!suggestions.contains(value)) {
      suggestions.insert(0, value);
      // الاحتفاظ بآخر 10 اقتراحات فقط
      if (suggestions.length > 10) {
        suggestions = suggestions.take(10).toList();
      }
      await prefs.setStringList('$_prefix$fieldKey', suggestions);
    } else {
      // نقل القيمة الموجودة للمقدمة
      suggestions.remove(value);
      suggestions.insert(0, value);
      await prefs.setStringList('$_prefix$fieldKey', suggestions);
    }
  }

  // استرداد الاقتراحات لحقل معين
  static Future<List<String>> getSuggestions(String fieldKey) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('$_prefix$fieldKey') ?? [];
  }

  // مسح الاقتراحات لحقل معين
  static Future<void> clearSuggestions(String fieldKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_prefix$fieldKey');
  }

  // مسح كل الاقتراحات
  static Future<void> clearAllSuggestions() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().where((key) => key.startsWith(_prefix));
    for (String key in keys) {
      await prefs.remove(key);
    }
  }
}

// Custom AutoComplete TextField Widget
class CustomAutoCompleteTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String fieldKey;
  final TextInputType? keyboardType;

  const CustomAutoCompleteTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.fieldKey,
    this.keyboardType,
  });

  @override
  State<CustomAutoCompleteTextField> createState() =>
      _CustomAutoCompleteTextFieldState();
}

class _CustomAutoCompleteTextFieldState
    extends State<CustomAutoCompleteTextField> {
  List<String> suggestions = [];

  @override
  void initState() {
    super.initState();
    _loadSuggestions();
  }

  Future<void> _loadSuggestions() async {
    suggestions = await AutoCompleteService.getSuggestions(widget.fieldKey);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return suggestions.take(5);
        }
        return suggestions
            .where((String option) {
              return option.toLowerCase().contains(
                textEditingValue.text.toLowerCase(),
              );
            })
            .take(5);
      },
      onSelected: (String selection) {
        widget.controller.text = selection;
        AutoCompleteService.saveSuggestion(widget.fieldKey, selection);
      },
      fieldViewBuilder:
          (
            BuildContext context,
            TextEditingController fieldController,
            FocusNode fieldFocusNode,
            VoidCallback onFieldSubmitted,
          ) {
            fieldController.text = widget.controller.text;
            fieldController.addListener(() {
              widget.controller.text = fieldController.text;
            });

            return CustomTextFormField(
              controller: fieldController,
              hintText: widget.hintText,
              keyboardType: widget.keyboardType,
              onFieldSubmitted: (value) {
                onFieldSubmitted();
                if (value.trim().isNotEmpty == true) {
                  AutoCompleteService.saveSuggestion(widget.fieldKey, value);
                }
              },
            );
          },
      optionsViewBuilder:
          (
            BuildContext context,
            AutocompleteOnSelected<String> onSelected,
            Iterable<String> options,
          ) {
            return Align(
              alignment: Alignment.topRight,
              child: Material(
                elevation: 8.0,
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
                shadowColor: Colors.black26,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 200,
                    maxWidth: 300,
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    shrinkWrap: true,
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final String option = options.elementAt(index);
                      return InkWell(
                        onTap: () => onSelected(option),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 12.0,
                          ),
                          decoration: BoxDecoration(
                            border: index < options.length - 1
                                ? Border(
                                    bottom: BorderSide(
                                      color: Colors.grey.shade200,
                                      width: 1,
                                    ),
                                  )
                                : null,
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.history, size: 16, color: Colors.grey),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  option,
                                  style: AppStyle.styleRegular14(context),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
    );
  }
}

class ConfirmAddress extends StatefulWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController address1Controller;
  final TextEditingController address2Controller;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController postcodeController;
  final TextEditingController countryController;
  final TextEditingController shippingFirstNameController;
  final TextEditingController shippingLastNameController;
  final TextEditingController shippingAddress1Controller;
  final TextEditingController shippingAddress2Controller;
  final TextEditingController shippingCityController;
  final TextEditingController shippingStateController;
  final TextEditingController shippingPostcodeController;
  final TextEditingController shippingCountryController;

  const ConfirmAddress({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
    required this.address1Controller,
    required this.address2Controller,
    required this.cityController,
    required this.stateController,
    required this.postcodeController,
    required this.countryController,
    required this.shippingFirstNameController,
    required this.shippingLastNameController,
    required this.shippingAddress1Controller,
    required this.shippingAddress2Controller,
    required this.shippingCityController,
    required this.shippingStateController,
    required this.shippingPostcodeController,
    required this.shippingCountryController,
  });

  @override
  State<ConfirmAddress> createState() => _ConfirmAddressState();
}

class _ConfirmAddressState extends State<ConfirmAddress> {
  bool _isLoading = false;
  bool _sameAsShipping = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          // زر لمسح كل الاقتراحات
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'clear') {
                await AutoCompleteService.clearAllSuggestions();
              } else if (value == 'copy') {
                _copyBillingToShipping();
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'copy',
                child: Row(
                  children: [
                    Icon(Icons.copy, size: 20),
                    SizedBox(width: 8),
                    Text('نسخ بيانات الفوترة للشحن'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'clear',
                child: Row(
                  children: [
                    Icon(Icons.clear_all, size: 20),
                    SizedBox(width: 8),
                    Text('مسح كل الاقتراحات'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25.h),

            Text(
              "بياناتك",
              style: AppStyle.styleRegular16(
                context,
              ).copyWith(color: AppColors.primaryColor),
            ),

            _buildAutoCompleteField(
              "الاسم الأول",
              widget.firstNameController,
              "firstName",
            ),
            _buildAutoCompleteField(
              "الاسم الأخير",
              widget.lastNameController,
              "lastName",
            ),
            _buildAutoCompleteField(
              "البريد الإلكتروني",
              widget.emailController,
              "email",
              TextInputType.emailAddress,
            ),
            _buildAutoCompleteField(
              "رقم الهاتف",
              widget.phoneController,
              "phone",
              TextInputType.phone,
            ),
            _buildAutoCompleteField(
              "العنوان 1",
              widget.address1Controller,
              "address1",
            ),
            _buildAutoCompleteField(
              "العنوان 2",
              widget.address2Controller,
              "address2",
            ),
            _buildAutoCompleteField("المدينة", widget.cityController, "city"),
            _buildAutoCompleteField(
              "المحافظة",
              widget.stateController,
              "state",
            ),
            _buildAutoCompleteField(
              "الرمز البريدي",
              widget.postcodeController,
              "postcode",
            ),
            _buildAutoCompleteField(
              "الدولة",
              widget.countryController,
              "country",
            ),

            const SizedBox(height: 24),

            // خيار نسخ بيانات الفوترة لعنوان الشحن
            CheckboxListTile(
              title: const Text("عنوان الشحن نفس عنوان الفوترة"),
              value: _sameAsShipping,
              onChanged: (value) {
                setState(() {
                  _sameAsShipping = value ?? false;
                  if (_sameAsShipping) {
                    _copyBillingToShipping();
                  } else {
                    _clearShippingFields();
                  }
                });
              },
            ),

            if (!_sameAsShipping) ...[
              Text(
                "عنوان الشحن",
                style: AppStyle.styleRegular16(
                  context,
                ).copyWith(color: AppColors.primaryColor),
              ),

              _buildAutoCompleteField(
                "الاسم الأول",
                widget.shippingFirstNameController,
                "shippingFirstName",
              ),
              _buildAutoCompleteField(
                "الاسم الأخير",
                widget.shippingLastNameController,
                "shippingLastName",
              ),
              _buildAutoCompleteField(
                "العنوان 1",
                widget.shippingAddress1Controller,
                "shippingAddress1",
              ),
              _buildAutoCompleteField(
                "العنوان 2",
                widget.shippingAddress2Controller,
                "shippingAddress2",
              ),
              _buildAutoCompleteField(
                "المدينة",
                widget.shippingCityController,
                "shippingCity",
              ),
              _buildAutoCompleteField(
                "المحافظة",
                widget.shippingStateController,
                "shippingState",
              ),
              _buildAutoCompleteField(
                "الرمز البريدي",
                widget.shippingPostcodeController,
                "shippingPostcode",
              ),
              _buildAutoCompleteField(
                "الدولة",
                widget.shippingCountryController,
                "shippingCountry",
              ),
            ],

            const SizedBox(height: 24),

            CustomElevatedButton(
              onPressed: _isLoading
                  ? () {}
                  : () {
                      _saveAddressData();
                    },
              child: _isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    )
                  : Text(
                      "حفظ",
                      style: AppStyle.styleRegular15(
                        context,
                      ).copyWith(color: Colors.white),
                    ),
            ),

            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAutoCompleteField(
    String label,
    TextEditingController controller,
    String fieldKey, [
    TextInputType? keyboardType,
  ]) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: CustomAutoCompleteTextField(
        controller: controller,
        hintText: label,
        fieldKey: fieldKey,
        keyboardType: keyboardType,
      ),
    );
  }

  void _copyBillingToShipping() {
    widget.shippingFirstNameController.text = widget.firstNameController.text;
    widget.shippingLastNameController.text = widget.lastNameController.text;
    widget.shippingAddress1Controller.text = widget.address1Controller.text;
    widget.shippingAddress2Controller.text = widget.address2Controller.text;
    widget.shippingCityController.text = widget.cityController.text;
    widget.shippingStateController.text = widget.stateController.text;
    widget.shippingPostcodeController.text = widget.postcodeController.text;
    widget.shippingCountryController.text = widget.countryController.text;
  }

  void _clearShippingFields() {
    widget.shippingFirstNameController.clear();
    widget.shippingLastNameController.clear();
    widget.shippingAddress1Controller.clear();
    widget.shippingAddress2Controller.clear();
    widget.shippingCityController.clear();
    widget.shippingStateController.clear();
    widget.shippingPostcodeController.clear();
    widget.shippingCountryController.clear();
  }

  Future<void> _saveAddressData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // حفظ جميع القيم كاقتراحات للمستقبل
      await _saveAllSuggestions();

      // إنشاء object يحتوي على كل القيم
      AddressData addressData = AddressData(
        firstName: widget.firstNameController.text,
        lastName: widget.lastNameController.text,
        email: widget.emailController.text,
        phone: widget.phoneController.text,
        address1: widget.address1Controller.text,
        address2: widget.address2Controller.text,
        city: widget.cityController.text,
        state: widget.stateController.text,
        postcode: widget.postcodeController.text,
        country: widget.countryController.text,
        shippingFirstName: _sameAsShipping
            ? widget.firstNameController.text
            : widget.shippingFirstNameController.text,
        shippingLastName: _sameAsShipping
            ? widget.lastNameController.text
            : widget.shippingLastNameController.text,
        shippingAddress1: _sameAsShipping
            ? widget.address1Controller.text
            : widget.shippingAddress1Controller.text,
        shippingAddress2: _sameAsShipping
            ? widget.address2Controller.text
            : widget.shippingAddress2Controller.text,
        shippingCity: _sameAsShipping
            ? widget.cityController.text
            : widget.shippingCityController.text,
        shippingState: _sameAsShipping
            ? widget.stateController.text
            : widget.shippingStateController.text,
        shippingPostcode: _sameAsShipping
            ? widget.postcodeController.text
            : widget.shippingPostcodeController.text,
        shippingCountry: _sameAsShipping
            ? widget.countryController.text
            : widget.shippingCountryController.text,
      );

      // تأخير بسيط لإظهار Loading
      await Future.delayed(const Duration(milliseconds: 500));

      GoRouter.of(context).pop(addressData);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("حدث خطأ أثناء حفظ البيانات"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveAllSuggestions() async {
    final fields = {
      'firstName': widget.firstNameController.text,
      'lastName': widget.lastNameController.text,
      'email': widget.emailController.text,
      'phone': widget.phoneController.text,
      'address1': widget.address1Controller.text,
      'address2': widget.address2Controller.text,
      'city': widget.cityController.text,
      'state': widget.stateController.text,
      'postcode': widget.postcodeController.text,
      'country': widget.countryController.text,
    };

    if (!_sameAsShipping) {
      fields.addAll({
        'shippingFirstName': widget.shippingFirstNameController.text,
        'shippingLastName': widget.shippingLastNameController.text,
        'shippingAddress1': widget.shippingAddress1Controller.text,
        'shippingAddress2': widget.shippingAddress2Controller.text,
        'shippingCity': widget.shippingCityController.text,
        'shippingState': widget.shippingStateController.text,
        'shippingPostcode': widget.shippingPostcodeController.text,
        'shippingCountry': widget.shippingCountryController.text,
      });
    }

    for (final entry in fields.entries) {
      if (entry.value.trim().isNotEmpty) {
        await AutoCompleteService.saveSuggestion(entry.key, entry.value);
      }
    }
  }
}
