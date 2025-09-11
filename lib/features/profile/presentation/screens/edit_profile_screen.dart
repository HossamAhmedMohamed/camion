import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/config/widgets/custom_text_form_field.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/profile/presentation/logic/cubit/update_user_cubit/update_user_cubit.dart';
import 'package:camion/features/profile/presentation/screens/my_info.dart';
import 'package:camion/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class EditInfoScreen extends StatefulWidget {
  const EditInfoScreen({
    super.key,
    required this.fullName,
    required this.phone,
    required this.email,
  });
  final String fullName;
  final String phone;
  final String email;
  @override
  State<EditInfoScreen> createState() => _EditInfoScreenState();
}

class _EditInfoScreenState extends State<EditInfoScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  late String currentFullName;
  late String currentPhone;
  late String currentEmail;

  @override
  void initState() {
    currentFullName = widget.fullName;
    currentPhone = widget.phone;
    currentEmail = widget.email;

    nameController.text = currentFullName;
    phoneController.text = currentPhone;
    emailController.text = currentEmail;
    super.initState();
  }

  bool isEnabled = false;

  void checkIfValuesChanged() {
    bool hasChanged =
        (nameController.text.isNotEmpty &&
            nameController.text != currentFullName) ||
        (emailController.text.isNotEmpty &&
            emailController.text != currentEmail) ||
        (phoneController.text.isNotEmpty &&
            phoneController.text != currentPhone);

    setState(() {
      isEnabled = hasChanged;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 15.h)),
          CustomSliverAppBar(
            appBarHeight: 70.h,
            title: Text(
               S.of(context).edit_profile,
              style: AppStyle.styleRegular18(
                context,
              ).copyWith(color: AppColors.black, fontWeight: FontWeight.w500),
            ),
            isShownDivider: true,
            leading: GestureDetector(
              onTap: () {
                GoRouter.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back,
                color: AppColors.black,
                size: 24.sp,
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: SvgPicture.asset(
                  width: 26.w,
                  height: 26.h,
                  Assets.imagesIconsActiveEditInfo,
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(child: SizedBox(height: 25.h)),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  SizedBox(height: 20.h),

                  Row(
                    children: [
                      Text(
                         S.of(context).full_name,
                        style: AppStyle.styleRegular16(
                          context,
                        ).copyWith(color: Colors.black),
                      ),
                      SizedBox(width: 15.w),
                      SvgPicture.asset(Assets.imagesIconsEditInfo),
                    ],
                  ),
                  SizedBox(height: 8.h),

                  CustomTextFormField(
                    hintText:  S.of(context).full_name,
                    controller: nameController,
                    onChanged: (value) {
                      checkIfValuesChanged();
                    },
                  ),

                  SizedBox(height: 20.h),

                  Row(
                    children: [
                      Text(
                         S.of(context).email,
                        style: AppStyle.styleRegular16(
                          context,
                        ).copyWith(color: Colors.black),
                      ),
                      SizedBox(width: 15.w),
                      SvgPicture.asset(Assets.imagesIconsEditInfo),
                    ],
                  ),
                  SizedBox(height: 8.h),

                  CustomTextFormField(
                    hintText:  S.of(context).email,
                    controller: emailController,
                    onChanged: (value) {
                      checkIfValuesChanged();
                    },
                  ),

                  SizedBox(height: 20.h),

                  Row(
                    children: [
                      Text(
                         S.of(context).phone_Number,
                        style: AppStyle.styleRegular16(
                          context,
                        ).copyWith(color: Colors.black),
                      ),
                      SizedBox(width: 15.w),
                      SvgPicture.asset(Assets.imagesIconsEditInfo),
                    ],
                  ),
                  SizedBox(height: 8.h),

                  CustomTextFormField(
                    hintText:  S.of(context).phone_Number,
                    controller: phoneController,
                    onChanged: (value) {
                      checkIfValuesChanged();
                    },
                  ),

                  SizedBox(height: 30.h),

                  BlocConsumer<UpdateUserCubit, UpdateUserState>(
                    listener: (context, state) {
                      if (state is UpdateUserLoaded) {
                        currentFullName = nameController.text;
                        currentEmail = emailController.text;
                        currentPhone = phoneController.text;

                        setState(() {
                          isEnabled = false;
                        });

                        Fluttertoast.showToast(
                          gravity: ToastGravity.TOP,
                          backgroundColor: Colors.green,
                          msg: S.of(context).profile_updated_successfully,
                        );
                        MyInfoScreen.profileKey.currentState!.refreshGetUser();
                      }
                      if (state is UpdateUserError) {
                        Fluttertoast.showToast(
                          gravity: ToastGravity.TOP,
                          backgroundColor: Colors.red,
                          msg: state.error.message,
                        );
                      }
                    },
                    builder: (context, state) {
                      return CustomElevatedButton(
                        backgroundColor: isEnabled
                            ? AppColors.primaryColor
                            : Colors.grey,
                        onPressed: isEnabled
                            ? () {
                                context.read<UpdateUserCubit>().updateUser(
                                  data: {
                                    "fullName": nameController.text,
                                    "email": emailController.text,
                                    "phone": phoneController.text,
                                  },
                                );
                              }
                            : () {},
                        child: state is UpdateUserLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                 S.of(context).save,
                                style: AppStyle.styleRegular16(
                                  context,
                                ).copyWith(color: Colors.white),
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ),
        ],
      ),
    );
  }
}
