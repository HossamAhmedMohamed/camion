import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/config/widgets/custom_text_form_field.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/join_us/presentation/widgets/custom__join_us_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateCodeScreen extends StatelessWidget {
  const CreateCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: CustomScrollView(
          slivers: [
            const CustomJoinUsSliverAppBar(title: "إنشاء كود"),
            SliverToBoxAdapter(child: SizedBox(height: 20.h)),

            const SliverToBoxAdapter(
              child: CustomTextFormField(hintText: "الكود"),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 20.h)),

            const SliverToBoxAdapter(
              child: CustomTextFormField(hintText: "نسبة الخصم"),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 20.h)),

            SliverToBoxAdapter(
              child: CustomElevatedButton(
                elevation: 0,
                textColor: AppColors.primaryColor,
                backgroundColor: AppColors.primaryColor.withAlpha(25),
                borderColor: AppColors.primaryColor,
                child: Text(
                  "انشاء",
                  style: AppStyle.styleRegular15(
                    context,
                  ).copyWith(color: Colors.white),
                ),
                onPressed: () {},
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ),
          ],
        ),
      ),
    );
  }
}
