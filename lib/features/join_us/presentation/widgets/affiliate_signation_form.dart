import 'package:camion/config/widgets/custom_text_form_field.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/join_us/presentation/widgets/gender_form_field.dart';
import 'package:camion/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AffiliateSignationForm extends StatefulWidget {
  const AffiliateSignationForm({
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
  State<AffiliateSignationForm> createState() => _AffiliateSignationFormState();
}

class _AffiliateSignationFormState extends State<AffiliateSignationForm> {
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
           S.of(context).personal_data,
          style: AppStyle.styleRegular18(
            context,
          ).copyWith(color: AppColors.black, fontWeight: FontWeight.w500),
        ),

        SizedBox(height: 15.h),
        SizedBox(height: 15.h),

        CustomTextFormField(
          controller: widget.fullNameController,
          hintText: S.of(context).full_name,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return S.of(context).please_enter_your_name;
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
              return  S.of(context).please_select_your_gender;
            }
            return null;
          },
        ),

        SizedBox(height: 10.h),

        CustomTextFormField(
          controller: widget.nationalityController,
          hintText: S.of(context).nationality,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return  S.of(context).please_select_your_nationality;
            }
            return null;
          },
        ),

        SizedBox(height: 10.h),

        CustomTextFormField(
          controller: widget.bioController, 
          hintText:  S.of(context).about_you,
          maxLines: 7,
          maxLength: 200,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return  S.of(context).please_enter_your_bio;
            }
            return null;
          },
        ),

        SizedBox(height: 10.h),
      ],
    );
  }
}
