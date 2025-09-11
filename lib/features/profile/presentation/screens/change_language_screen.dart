import 'package:camion/config/localization/cubit/localizations_cubit.dart';
import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/home/presentation/screens/home_screen.dart';
import 'package:camion/features/profile/data/models/change_language_model.dart';
import 'package:camion/features/profile/presentation/widgets/custom_radio_button.dart';
import 'package:camion/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({super.key});

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  // int selectedLanguage = -1;
  @override
  Widget build(BuildContext context) {
    List<ChangeLanguageModel> languages = [
  ChangeLanguageModel(
    languageCode: 'ar',
    onTap: () async {
      await context
          .read<LocalizationsCubit>()
          .changeLocale(locale: const Locale('ar'))
          .then(
            (value) => HomeScreen.homeKey.currentState?.refreshProducts(),
          );
    },
    title: S.of(context).arabic,
    isSelected:
        context.watch<LocalizationsCubit>().state.languageCode == 'ar',
  ),
  ChangeLanguageModel(
    languageCode: 'en',
    onTap: () async {
      await context
          .read<LocalizationsCubit>()
          .changeLocale(locale: const Locale('en'))
          .then(
            (value) => HomeScreen.homeKey.currentState?.refreshProducts(),
          );
    },
    title: S.of(context).english,
    isSelected:
        context.watch<LocalizationsCubit>().state.languageCode == 'en',
  ),
  ChangeLanguageModel(
    languageCode: 'de',
    onTap: () async {
      await context
          .read<LocalizationsCubit>()
          .changeLocale(locale: const Locale('de'))
          .then(
            (value) => HomeScreen.homeKey.currentState?.refreshProducts(),
          );
    },
    title: S.of(context).german,
    isSelected:
        context.watch<LocalizationsCubit>().state.languageCode == 'de',
  ),
  ChangeLanguageModel(
    languageCode: 'fr',
    onTap: () async {
      await context
          .read<LocalizationsCubit>()
          .changeLocale(locale: const Locale('fr'))
          .then(
            (value) => HomeScreen.homeKey.currentState?.refreshProducts(),
          );
    },
    title: S.of(context).french,
    isSelected:
        context.watch<LocalizationsCubit>().state.languageCode == 'fr',
  ),
  ChangeLanguageModel(
    languageCode: 'es',
    onTap: () async {
      await context
          .read<LocalizationsCubit>()
          .changeLocale(locale: const Locale('es'))
          .then(
            (value) => HomeScreen.homeKey.currentState?.refreshProducts(),
          );
    },
    title: S.of(context).spanish,
    isSelected:
        context.watch<LocalizationsCubit>().state.languageCode == 'es',
  ),
  ChangeLanguageModel(
    languageCode: 'it',
    onTap: () async {
      await context
          .read<LocalizationsCubit>()
          .changeLocale(locale: const Locale('it'))
          .then(
            (value) => HomeScreen.homeKey.currentState?.refreshProducts(),
          );
    },
    title: S.of(context).italian,
    isSelected:
        context.watch<LocalizationsCubit>().state.languageCode == 'it',
  ),
  ChangeLanguageModel(
    languageCode: 'bn',
    onTap: () async {
      await context
          .read<LocalizationsCubit>()
          .changeLocale(locale: const Locale('bn'))
          .then(
            (value) => HomeScreen.homeKey.currentState?.refreshProducts(),
          );
    },
    title: S.of(context).bengali,
    isSelected:
        context.watch<LocalizationsCubit>().state.languageCode == 'bn',
  ),
  ChangeLanguageModel(
    languageCode: 'nl',
    onTap: () async {
      await context
          .read<LocalizationsCubit>()
          .changeLocale(locale: const Locale('nl'))
          .then(
            (value) => HomeScreen.homeKey.currentState?.refreshProducts(),
          );
    },
    title: S.of(context).dutch,
    isSelected:
        context.watch<LocalizationsCubit>().state.languageCode == 'nl',
  ),
  ChangeLanguageModel(
    languageCode: 'hi',
    onTap: () async {
      await context
          .read<LocalizationsCubit>()
          .changeLocale(locale: const Locale('hi'))
          .then(
            (value) => HomeScreen.homeKey.currentState?.refreshProducts(),
          );
    },
    title: S.of(context).hindi,
    isSelected:
        context.watch<LocalizationsCubit>().state.languageCode == 'hi',
  ),
  ChangeLanguageModel(
    languageCode: 'id',
    onTap: () async {
      await context
          .read<LocalizationsCubit>()
          .changeLocale(locale: const Locale('id'))
          .then(
            (value) => HomeScreen.homeKey.currentState?.refreshProducts(),
          );
    },
    title: S.of(context).indonesian,
    isSelected:
        context.watch<LocalizationsCubit>().state.languageCode == 'id',
  ),
  ChangeLanguageModel(
    languageCode: 'ja',
    onTap: () async {
      await context
          .read<LocalizationsCubit>()
          .changeLocale(locale: const Locale('ja'))
          .then(
            (value) => HomeScreen.homeKey.currentState?.refreshProducts(),
          );
    },
    title: S.of(context).japanese,
    isSelected:
        context.watch<LocalizationsCubit>().state.languageCode == 'ja',
  ),
  ChangeLanguageModel(
    languageCode: 'jv',
    onTap: () async {
      await context
          .read<LocalizationsCubit>()
          .changeLocale(locale: const Locale('jv'))
          .then(
            (value) => HomeScreen.homeKey.currentState?.refreshProducts(),
          );
    },
    title: S.of(context).javanese,
    isSelected:
        context.watch<LocalizationsCubit>().state.languageCode == 'jv',
  ),
  ChangeLanguageModel(
    languageCode: 'ko',
    onTap: () async {
      await context
          .read<LocalizationsCubit>()
          .changeLocale(locale: const Locale('ko'))
          .then(
            (value) => HomeScreen.homeKey.currentState?.refreshProducts(),
          );
    },
    title: S.of(context).korean,
    isSelected:
        context.watch<LocalizationsCubit>().state.languageCode == 'ko',
  ),
  ChangeLanguageModel(
    languageCode: 'ms',
    onTap: () async {
      await context
          .read<LocalizationsCubit>()
          .changeLocale(locale: const Locale('ms'))
          .then(
            (value) => HomeScreen.homeKey.currentState?.refreshProducts(),
          );
    },
    title: S.of(context).malay,
    isSelected:
        context.watch<LocalizationsCubit>().state.languageCode == 'ms',
  ),
  ChangeLanguageModel(
    languageCode: 'zh',
    onTap: () async {
      await context
          .read<LocalizationsCubit>()
          .changeLocale(locale: const Locale('zh'))
          .then(
            (value) => HomeScreen.homeKey.currentState?.refreshProducts(),
          );
    },
    title: S.of(context).mandarin_chinese,
    isSelected:
        context.watch<LocalizationsCubit>().state.languageCode == 'zh',
  ),
  ChangeLanguageModel(
    languageCode: 'mr',
    onTap: () async {
      await context
          .read<LocalizationsCubit>()
          .changeLocale(locale: const Locale('mr'))
          .then(
            (value) => HomeScreen.homeKey.currentState?.refreshProducts(),
          );
    },
    title: S.of(context).marathi,
    isSelected:
        context.watch<LocalizationsCubit>().state.languageCode == 'mr',
  ),
  ChangeLanguageModel(
    languageCode: 'fa',
    onTap: () async {
      await context
          .read<LocalizationsCubit>()
          .changeLocale(locale: const Locale('fa'))
          .then(
            (value) => HomeScreen.homeKey.currentState?.refreshProducts(),
          );
    },
    title: S.of(context).persian,
    isSelected:
        context.watch<LocalizationsCubit>().state.languageCode == 'fa',
  ),
  ChangeLanguageModel(
    languageCode: 'pl',
    onTap: () async {
      await context
          .read<LocalizationsCubit>()
          .changeLocale(locale: const Locale('pl'))
          .then(
            (value) => HomeScreen.homeKey.currentState?.refreshProducts(),
          );
    },
    title: S.of(context).polish,
    isSelected:
        context.watch<LocalizationsCubit>().state.languageCode == 'pl',
  ),
  ChangeLanguageModel(
    languageCode: 'pt',
    onTap: () async {
      await context
          .read<LocalizationsCubit>()
          .changeLocale(locale: const Locale('pt'))
          .then(
            (value) => HomeScreen.homeKey.currentState?.refreshProducts(),
          );
    },
    title: S.of(context).portuguese,
    isSelected:
        context.watch<LocalizationsCubit>().state.languageCode == 'pt',
  ),
  ChangeLanguageModel(
    languageCode: 'pa',
    onTap: () async {
      await context
          .read<LocalizationsCubit>()
          .changeLocale(locale: const Locale('pa'))
          .then(
            (value) => HomeScreen.homeKey.currentState?.refreshProducts(),
          );
    },
    title: S.of(context).punjabi,
    isSelected:
        context.watch<LocalizationsCubit>().state.languageCode == 'pa',
  ),
  ChangeLanguageModel(
    languageCode: 'ro',
    onTap: () async {
      await context
          .read<LocalizationsCubit>()
          .changeLocale(locale: const Locale('ro'))
          .then(
            (value) => HomeScreen.homeKey.currentState?.refreshProducts(),
          );
    },
    title: S.of(context).romanian,
    isSelected:
        context.watch<LocalizationsCubit>().state.languageCode == 'ro',
  ),
  ChangeLanguageModel(
    languageCode: 'ru',
    onTap: () async {
      await context
          .read<LocalizationsCubit>()
          .changeLocale(locale: const Locale('ru'))
          .then(
            (value) => HomeScreen.homeKey.currentState?.refreshProducts(),
          );
    },
    title: S.of(context).russian,
    isSelected:
        context.watch<LocalizationsCubit>().state.languageCode == 'ru',
  ),
  ChangeLanguageModel(
    languageCode: 'sw',
    onTap: () async {
      await context
          .read<LocalizationsCubit>()
          .changeLocale(locale: const Locale('sw'))
          .then(
            (value) => HomeScreen.homeKey.currentState?.refreshProducts(),
          );
    },
    title: S.of(context).swahili,
    isSelected:
        context.watch<LocalizationsCubit>().state.languageCode == 'sw',
  ),
  ChangeLanguageModel(
    languageCode: 'ta',
    onTap: () async {
      await context
          .read<LocalizationsCubit>()
          .changeLocale(locale: const Locale('ta'))
          .then(
            (value) => HomeScreen.homeKey.currentState?.refreshProducts(),
          );
    },
    title: S.of(context).tamil,
    isSelected:
        context.watch<LocalizationsCubit>().state.languageCode == 'ta',
  ),
  ChangeLanguageModel(
    languageCode: 'te',
    onTap: () async {
      await context
          .read<LocalizationsCubit>()
          .changeLocale(locale: const Locale('te'))
          .then(
            (value) => HomeScreen.homeKey.currentState?.refreshProducts(),
          );
    },
    title: S.of(context).telugu,
    isSelected:
        context.watch<LocalizationsCubit>().state.languageCode == 'te',
  ),
  ChangeLanguageModel(
    languageCode: 'th',
    onTap: () async {
      await context
          .read<LocalizationsCubit>()
          .changeLocale(locale: const Locale('th'))
          .then(
            (value) => HomeScreen.homeKey.currentState?.refreshProducts(),
          );
    },
    title: S.of(context).thai,
    isSelected:
        context.watch<LocalizationsCubit>().state.languageCode == 'th',
  ),
  ChangeLanguageModel(
    languageCode: 'tr',
    onTap: () async {
      await context
          .read<LocalizationsCubit>()
          .changeLocale(locale: const Locale('tr'))
          .then(
            (value) => HomeScreen.homeKey.currentState?.refreshProducts(),
          );
    },
    title: S.of(context).turkish,
    isSelected:
        context.watch<LocalizationsCubit>().state.languageCode == 'tr',
  ),
  ChangeLanguageModel(
    languageCode: 'uk',
    onTap: () async {
      await context
          .read<LocalizationsCubit>()
          .changeLocale(locale: const Locale('uk'))
          .then(
            (value) => HomeScreen.homeKey.currentState?.refreshProducts(),
          );
    },
    title: S.of(context).ukrainian,
    isSelected:
        context.watch<LocalizationsCubit>().state.languageCode == 'uk',
  ),
  ChangeLanguageModel(
    languageCode: 'ur',
    onTap: () async {
      await context
          .read<LocalizationsCubit>()
          .changeLocale(locale: const Locale('ur'))
          .then(
            (value) => HomeScreen.homeKey.currentState?.refreshProducts(),
          );
    },
    title: S.of(context).urdu,
    isSelected:
        context.watch<LocalizationsCubit>().state.languageCode == 'ur',
  ),
  ChangeLanguageModel(
    languageCode: 'vi',
    onTap: () async {
      await context
          .read<LocalizationsCubit>()
          .changeLocale(locale: const Locale('vi'))
          .then(
            (value) => HomeScreen.homeKey.currentState?.refreshProducts(),
          );
    },
    title: S.of(context).vietnamese,
    isSelected:
        context.watch<LocalizationsCubit>().state.languageCode == 'vi',
  ),
];

    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,

      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 15.h)),
          CustomSliverAppBar(
            appBarHeight: 70.h,
            title: Text(
              S.of(context).change_language,
              style: AppStyle.styleRegular18(
                context,
              ).copyWith(color: AppColors.black),
            ),
            leading: GestureDetector(
              onTap: () {
                GoRouter.of(context).pop();
              },
              child: Icon(Icons.arrow_back, color: AppColors.black, size: 24.r),
            ),
            actions: const [],
          ),

          SliverToBoxAdapter(child: SizedBox(height: 15.h)),

          // SliverToBoxAdapter(
          //   child: Text(
          //     "اختر اللغة",
          //     style: AppStyle.styleRegular16(
          //       context,
          //     ).copyWith(
          //       color: AppColors.black,
          //       fontWeight: FontWeight.w500),
          //   ),
          // ),
          SliverToBoxAdapter(child: SizedBox(height: 10.h)),

          SliverList.builder(
            itemCount: languages.length,

            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  left: 20.w,
                  right: 20.w,
                  top: screenWidth > 800 ? 30.h : 12.h,
                  bottom: index == languages.length - 1 ? 20.h : 0,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 35.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(15),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 2.h),
                      ),
                    ],
                  ),
                  child: ListTile(
                    onTap: languages[index].onTap,
                    contentPadding: EdgeInsets.zero,
                    trailing: CustomRadio(
                      isSelected: languages[index].isSelected,
                    ),
                    title: Text(
                      languages[index].title,
                      style: AppStyle.styleSemiBold15(context).copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
