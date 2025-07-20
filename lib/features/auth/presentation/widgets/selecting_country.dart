 

import 'package:camion/config/widgets/custom_text_form_field.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/auth/presentation/widgets/all_contries_and_language_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SelectingCountry extends StatefulWidget {
  const SelectingCountry({
    super.key,
    required TextEditingController countryController,
  }) : _countryController = countryController;

  final TextEditingController _countryController;

  @override
  State<SelectingCountry> createState() => _SelectingCountryState();
}

class _SelectingCountryState extends State<SelectingCountry> {
  void _showCountryPicker() async {
    final selectedCountry = await showModalBottomSheet<String>(
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        TextEditingController localSearchController = TextEditingController();

        List<String> localFilteredCountries = List.from(allCountries);

        return StatefulBuilder(
          builder: (context, setModalState) {
            void filterLocal(String query) {
              setModalState(() {
                if (query.isEmpty) {
                  localFilteredCountries = List.from(allCountries);
                } else {
                  final searchQuery = query.trim();
                  localFilteredCountries = allCountries.where((country) {
                    // إزالة التشكيل والمسافات الزائدة
                    final cleanCountry = country.trim();
                    final cleanQuery = searchQuery;

                    return cleanCountry.contains(cleanQuery) ||
                        cleanCountry.toLowerCase().contains(
                          cleanQuery.toLowerCase(),
                        );
                  }).toList();
                }
              });
            }

            localSearchController.addListener(() {
              final value = localSearchController.text;

              filterLocal(value);
            });

            return Column(
              children: [
               
                Padding(
                  padding: EdgeInsets.all(12.r),
                  child: CustomTextFormField(
                    fieldColor: AppColors.primaryColor,
                    hintText: "ابحث عن دولة",
                    controller: localSearchController,
                     
                    prefixIcon: Icon(Icons.search, size: 24.sp),
                  ),
                ),
                Expanded(
                  child: localFilteredCountries.isEmpty
                      ? Center(
                          child: Text(
                            'لا توجد نتائج',
                            style: AppStyle.styleSemiBold18(context),
                          ),
                        )
                      : ListView.builder(
                          itemCount: localFilteredCountries.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                localFilteredCountries[index],
                                textAlign: TextAlign.right,
                              ),
                              onTap: () {
                                GoRouter.of(
                                  context,
                                ).pop(localFilteredCountries[index]);
                              },
                            );
                          },
                        ),
                ),
              ],
            );
          },
        );
      },
    );

    if (selectedCountry != null) {
      setState(() {
        widget._countryController.text = selectedCountry;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      readOnly: true,
      controller: widget._countryController,
      hintText: "الدولة",
      onTapOnSuffixIcon: _showCountryPicker,
      suffixIcon: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'الرجاء إدخال الدولة';
        }
        return null;
      },
    );
  }
}
