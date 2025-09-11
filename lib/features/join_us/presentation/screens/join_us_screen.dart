import 'package:camion/config/widgets/custom_box_decoration.dart';
import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/join_us/presentation/logic/cubit/Affiliate_sign_cubit/affiliate_sign_cubit.dart';
import 'package:camion/features/join_us/presentation/widgets/custom__join_us_sliver_app_bar.dart';
import 'package:camion/features/join_us/presentation/widgets/affiliate_signation_form.dart';
import 'package:camion/generated/l10n.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class JoinUsScreen extends StatefulWidget {
  const JoinUsScreen({super.key});

  @override
  State<JoinUsScreen> createState() => _JoinUsScreenState();
}

class _JoinUsScreenState extends State<JoinUsScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  String? selectedGender;

  @override
  void dispose() {
    fullNameController.dispose();
    nationalityController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              CustomJoinUsSliverAppBar(
                title: S.of(context).join_us_as_affiliate,
              ),
              SliverToBoxAdapter(child: SizedBox(height: 20.h)),

              SliverToBoxAdapter(
                child: Container(
                  decoration: getContainerBoxDecoration(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                  margin: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    bottom: 20.h,
                  ),

                  child: Form(
                    key: formKey,
                    child: AffiliateSignationForm(
                      fullNameController: fullNameController,
                      nationalityController: nationalityController,
                      bioController: bioController,
                      onGenderChanged: (gender) {
                        selectedGender = gender;
                      },
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 60.h)),

              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom,
                ),
              ),
            ],
          ),

          Positioned(
            bottom: 16.h,
            left: 16.w,
            right: 16.w,
            child: BlocConsumer<AffiliateSignCubit, AffiliateSignState>(
              listener: (context, state) {
                if (state is AffiliateSignSuccess) {
                  GoRouter.of(
                    context,
                  ).pushReplacement(AppRouter.affiliateCheckScreen);
                }
                if (state is AffiliateSignError) {
                  Fluttertoast.showToast(
                    msg: state.error.message,
                    backgroundColor: Colors.red,
                    gravity: ToastGravity.TOP,
                  );
                }
              },
              builder: (context, state) {
                return CustomElevatedButton(
                  onPressed: state is AffiliateSignLoading
                      ? () {}
                      : () {
                          formKey.currentState!.save();

                          if (!formKey.currentState!.validate()) {
                            return;
                          }

                          if (selectedGender == null ||
                              selectedGender!.isEmpty) {
                            Fluttertoast.showToast(
                              msg: "Please select a gender",
                              backgroundColor: Colors.red,
                            );
                            return;
                          }

                          context.read<AffiliateSignCubit>().signSupplier(
                            name: fullNameController.text,
                            nationality: nationalityController.text,
                            gender: selectedGender!,
                            bio: bioController.text,
                          );
                        },
                  child: state is AffiliateSignLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          S.of(context).next,
                          style: AppStyle.styleRegular15(
                            context,
                          ).copyWith(color: Colors.white),
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
