import 'package:camion/config/widgets/custom_text_form_field.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/join_us/presentation/widgets/gender_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SupplierSignationForm extends StatefulWidget {
  const SupplierSignationForm({
    super.key,
    required this.fullNameController,
    required this.nationalityController,
    required this.bioController,
    this.onGenderChanged,
  });

  final TextEditingController fullNameController;
  final TextEditingController nationalityController;
  final TextEditingController bioController;
  final Function(String?)? onGenderChanged;

  @override
  State<SupplierSignationForm> createState() => _SupplierSignationFormState();
}

class _SupplierSignationFormState extends State<SupplierSignationForm> {
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "البيانات الشخصية",
          style: AppStyle.styleRegular18(
            context,
          ).copyWith(color: AppColors.black, fontWeight: FontWeight.w500),
        ),

        SizedBox(height: 15.h),
        SizedBox(height: 15.h),

        CustomTextFormField(
          controller: widget.fullNameController,
          hintText: "الاسم بالكامل",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'الرجاء إدخال الاسم';
            }
            return null;
          },
        ),

        SizedBox(height: 10.h),

        GenderFormField(
          onSaved: (value) {
            selectedGender = value;

            if (widget.onGenderChanged != null) {
              widget.onGenderChanged!(value);
            }
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'الرجاء اختيار الجنس';
            }
            return null;
          },
        ),

        SizedBox(height: 10.h),

        CustomTextFormField(
          controller: widget.nationalityController,
          hintText: "الجنسية",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'الرجاء إدخال الجنسية';
            }
            return null;
          },
        ),

        SizedBox(height: 10.h),

        CustomTextFormField(
          controller: widget.bioController, // تصحيح المتغير هنا
          hintText: "نبذة عنك",
          maxLines: 7,
          maxLength: 200,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'الرجاء إدخال نبذة عنك';
            }
            return null;
          },
        ),

        SizedBox(height: 10.h),
      ],
    );
  }
}
