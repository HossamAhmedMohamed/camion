import 'package:camion/config/widgets/custom_text_form_field.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/auth/presentation/widgets/all_contries_and_language_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SelectingLanguage extends StatefulWidget {
  const SelectingLanguage({
    super.key,
    required TextEditingController languageController,
  }) : _languageController = languageController;

  final TextEditingController _languageController;

  @override
  State<SelectingLanguage> createState() => _SelectingLanguageState();
}

class _SelectingLanguageState extends State<SelectingLanguage> {
  void _showCountryPicker() async {
    final selectedLanguage = await showModalBottomSheet<String>(
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        TextEditingController localSearchController = TextEditingController();

        List<String> localFilteredLanguages = List.from(popularLanguages);

        return StatefulBuilder(
          builder: (context, setModalState) {
            void filterLocal(String query) {
              setModalState(() {
                if (query.isEmpty) {
                  localFilteredLanguages = List.from(popularLanguages);
                } else {
                  final searchQuery = query.trim();
                  localFilteredLanguages = popularLanguages.where((language) {
                    final cleanLanguage = language.trim();
                    final cleanQuery = searchQuery;

                    return cleanLanguage.contains(cleanQuery) ||
                        cleanLanguage.toLowerCase().contains(
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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // SizedBox(height: 200.h),
                Padding(
                  padding: EdgeInsets.all(12.r),
                  child: CustomTextFormField(
                    fieldColor: AppColors.primaryColor,
                    hintText: "ما هي لغتك",
                    controller: localSearchController,

                    prefixIcon: Icon(Icons.search, size: 24.sp),
                  ),
                ),
                Expanded(
                  child: localFilteredLanguages.isEmpty
                      ? Center(
                          child: Text(
                            'لا توجد نتائج',
                            style: AppStyle.styleSemiBold18(context),
                          ),
                        )
                      : ListView.builder(
                          itemCount: localFilteredLanguages.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                localFilteredLanguages[index],
                                textAlign: TextAlign.right,
                              ),
                              onTap: () {
                                GoRouter.of(
                                  context,
                                ).pop(localFilteredLanguages[index]);
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

    if (selectedLanguage != null) {
      setState(() {
        widget._languageController.text = selectedLanguage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: widget._languageController,
      hintText: "اللغة",

      suffixIcon: GestureDetector(
        onTap: _showCountryPicker,
        child: Container(
          padding: EdgeInsets.all(12.h),
          child: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.grey.shade700,
            size: 24.r,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'الرجاء إدخال اللغة';
        }
        return null;
      },
    );
  }
}
