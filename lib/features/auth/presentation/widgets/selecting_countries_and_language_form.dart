import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/auth/presentation/widgets/selecting_country.dart';
import 'package:camion/features/auth/presentation/widgets/selecting_language.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SelectingCountryAndLanguageForm extends StatefulWidget {
  const SelectingCountryAndLanguageForm({super.key});

  @override
  State<SelectingCountryAndLanguageForm> createState() =>
      _SelectingCountryAndLanguageFormState();
}

class _SelectingCountryAndLanguageFormState
    extends State<SelectingCountryAndLanguageForm> {
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _languageController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _countryController.dispose();
    _languageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SelectingCountry(countryController: _countryController),

          SizedBox(height: 10.h),

          SelectingLanguage(languageController: _languageController),

          SizedBox(height: 20.h),

          CustomElevatedButton(
            child: Text(
              "متابعة",
              style: AppStyle.styleRegular15(
                context,
              ).copyWith(color: Colors.white),
            ),
            onPressed: () {
              // if (!_formKey.currentState!.validate()) {
              //   return;
              // } else {}

              GoRouter.of(context).push(AppRouter.login);
            },
          ),
        ],
      ),
    );
  }
}
