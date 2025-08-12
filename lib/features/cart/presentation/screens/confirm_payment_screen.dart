import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/config/widgets/custom_modal_bottom_sheet.dart';
import 'package:camion/config/widgets/custom_text_form_field.dart';
import 'package:camion/config/widgets/expanded_row_for_user.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/cart/data/models/get_cart_model.dart';
import 'package:camion/features/cart/presentation/widgets/cart_sliver_app_bar.dart';
import 'package:camion/features/cart/presentation/widgets/confirmation_products.dart';
import 'package:camion/features/order_status/presentation/logic/cubit/create_order_cubit/create_order_cubit.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class ConfirmPaymentScreen extends StatefulWidget {
  const ConfirmPaymentScreen({super.key, required this.cartList});

  final List<GetCartModel> cartList;

  @override
  State<ConfirmPaymentScreen> createState() => _ConfirmPaymentScreenState();
}

class _ConfirmPaymentScreenState extends State<ConfirmPaymentScreen> {
  String? selectedAddress;
  // null يعني لسه مفيش عنوان
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController address2Controller = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController postcodeController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController shippingFirstNameController =
      TextEditingController();
  final TextEditingController shippingLastNameController =
      TextEditingController();
  final TextEditingController shippingAddress1Controller =
      TextEditingController();
  final TextEditingController shippingAddress2Controller =
      TextEditingController();
  final TextEditingController shippingCityController = TextEditingController();
  final TextEditingController shippingStateController = TextEditingController();
  final TextEditingController shippingPostcodeController =
      TextEditingController();
  final TextEditingController shippingCountryController =
      TextEditingController();

  final TextEditingController creditCardController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    address1Controller.dispose();
    address2Controller.dispose();
    cityController.dispose();
    stateController.dispose();
    postcodeController.dispose();
    countryController.dispose();
    shippingFirstNameController.dispose();
    shippingLastNameController.dispose();
    shippingAddress1Controller.dispose();
    shippingAddress2Controller.dispose();
    shippingCityController.dispose();
    shippingStateController.dispose();
    shippingPostcodeController.dispose();
    shippingCountryController.dispose();
    creditCardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          const CartSliverAppBar(title: "اتمام الدفع"),

          SliverToBoxAdapter(child: SizedBox(height: 10.h)),

          // 🔹 عنوان المنتجات
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "المنتجات ",
                    style: AppStyle.styleBold16(
                      context,
                    ).copyWith(color: AppColors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.myCart);
                    },
                    child: Text(
                      "تعديل الطلب ",
                      style: AppStyle.styleRegular12(context).copyWith(
                        color: AppColors.primaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primaryColor,
                        decorationThickness: 1.5,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 20.h)),

          // 🔹 عرض المنتجات
          SliverToBoxAdapter(
            child: SizedBox(
              height: screenWidth > 800 ? 150.h : 100.h,
              child: ListView.builder(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                shrinkWrap: true,
                itemCount: widget.cartList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: ConfirmationsProductsItem(
                      imageUrl: widget.cartList[index].image!,
                      productName: widget.cartList[index].title!,
                      price: widget.cartList[index].price!,
                    ),
                  );
                },
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 30.h)),

          // 🔹 تفاصيل العنوان
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  ExpandedRowForUserImplementation(
                    // firstTitle: "تفاصيل العنوان",
                    secondTitle: "أضف بياناتك",
                    onTapOnSecondTitle: () async {
                      final result = await GoRouter.of(context).push(
                        AppRouter.confirmAddress,
                        extra: {
                          "firstName": firstNameController,
                          "lastName": lastNameController,
                          "email": emailController,
                          "phone": phoneController,
                          "address1": address1Controller,
                          "address2": address2Controller,
                          "city": cityController,
                          "state": stateController,
                          "postcode": postcodeController,
                          "country": countryController,
                          "shippingFirstName": shippingFirstNameController,
                          "shippingLastName": shippingLastNameController,
                          "shippingAddress1": shippingAddress1Controller,
                          "shippingAddress2": shippingAddress2Controller,
                          "shippingCity": shippingCityController,
                          "shippingState": shippingStateController,
                          "shippingPostcode": shippingPostcodeController,
                          "shippingCountry": shippingCountryController,
                          "creditCard": creditCardController,
                        },
                      );

                      if (result != null && result is String) {
                        setState(() {
                          selectedAddress = result;
                        });
                      }
                    },
                  ),
                  // SizedBox(height: 25.h),
                  // Text(
                  //   selectedAddress ?? "لم يتم تحديد عنوانك بعد",
                  //   style: AppStyle.styleRegular15(
                  //     context,
                  //   ).copyWith(color: AppColors.gray),
                  // ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 30.h)),

          // 🔹 كود الخصم
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "كود الخصم",
                    style: AppStyle.styleBold16(
                      context,
                    ).copyWith(color: AppColors.black),
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: CustomTextFormField(hintText: "كود الخصم"),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: SizedBox(
                          height: 52.h,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                                side: const BorderSide(
                                  color: AppColors.primaryColor,
                                  width: 1.5,
                                ),
                              ),
                            ),
                            child: FittedBox(
                              child: Text(
                                "تأكيد",
                                style: AppStyle.styleBold16(
                                  context,
                                ).copyWith(color: AppColors.primaryColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 30.h)),

          SliverToBoxAdapter(
            // hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
                child: BlocConsumer<CreateOrderCubit, CreateOrderState>(
                  listener: (context, state) {
                    if (state is CreateOrderSuccess) {
                      Fluttertoast.showToast(
                        msg: "تم تاكيد الدفع بنجاح",
                        gravity: ToastGravity.TOP,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.sp,
                      );
                    }
                    if (state is CreateOrderError) {
                      Fluttertoast.showToast(
                        msg: state.error.message,
                        gravity: ToastGravity.TOP,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.sp,
                      );
                    }
                  },
                  builder: (context, state) {
                    return CustomElevatedButton(
                      verticalPadding: 4.h,
                      height: 60.h,
                      onPressed: state is CreateOrderLoading ? (){} : () {
                        context.read<CreateOrderCubit>().createOrder(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                          address1: address1Controller.text,
                          address2: address2Controller.text,
                          city: cityController.text,
                          state: stateController.text,
                          postcode: postcodeController.text,
                          country: countryController.text,
                          shippingFirstName: shippingFirstNameController.text,
                          shippingLastName: shippingLastNameController.text,
                          shippingAddress1: shippingAddress1Controller.text,
                          shippingAddress2: shippingAddress2Controller.text,
                          shippingCity: shippingCityController.text,
                          shippingState: shippingStateController.text,
                          shippingPostcode: shippingPostcodeController.text,
                          shippingCountry: shippingCountryController.text,
                          paymentMethod: "stripe",
                          paymentMethodId: creditCardController.text,
                        );
                      },
                      child: state is CreateOrderLoading ? const CircularProgressIndicator(color: Colors.white) : Text(
                        "تأكيد الدفع",
                        style: AppStyle.styleRegular15(
                          context,
                        ).copyWith(color: Colors.white),
                      ),
                    );
                  },
                ),
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
