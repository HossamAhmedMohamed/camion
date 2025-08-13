import 'dart:developer';

import 'package:camion/config/widgets/custom_elevated_button.dart';
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

// إضافة الـ model اللي عملناه في الصفحة التانية
class AddressData {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String address1;
  final String address2;
  final String city;
  final String state;
  final String postcode;
  final String country;
  final String shippingFirstName;
  final String shippingLastName;
  final String shippingAddress1;
  final String shippingAddress2;
  final String shippingCity;
  final String shippingState;
  final String shippingPostcode;
  final String shippingCountry;

  AddressData({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
    required this.shippingFirstName,
    required this.shippingLastName,
    required this.shippingAddress1,
    required this.shippingAddress2,
    required this.shippingCity,
    required this.shippingState,
    required this.shippingPostcode,
    required this.shippingCountry,
  });
}

class ConfirmPaymentScreen extends StatefulWidget {
  const ConfirmPaymentScreen({super.key, required this.cartList});

  final List<GetCartModel> cartList;

  @override
  State<ConfirmPaymentScreen> createState() => _ConfirmPaymentScreenState();
}

class _ConfirmPaymentScreenState extends State<ConfirmPaymentScreen> {
  String? selectedAddress;

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

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  ExpandedRowForUserImplementation(
                    secondTitle: "أضف بياناتك",
                    onTapOnSecondTitle: () async {
                      // تمرير الـ Controllers للصفحة التانية
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
                        },
                      );

                      if (result != null && result is AddressData) {
                        setState(() {
                          firstNameController.text = result.firstName;
                          lastNameController.text = result.lastName;
                          emailController.text = result.email;
                          phoneController.text = result.phone;
                          address1Controller.text = result.address1;
                          address2Controller.text = result.address2;
                          cityController.text = result.city;
                          stateController.text = result.state;
                          postcodeController.text = result.postcode;
                          countryController.text = result.country;
                          shippingFirstNameController.text =
                              result.shippingFirstName;
                          shippingLastNameController.text =
                              result.shippingLastName;
                          shippingAddress1Controller.text =
                              result.shippingAddress1;
                          shippingAddress2Controller.text =
                              result.shippingAddress2;
                          shippingCityController.text = result.shippingCity;
                          shippingStateController.text = result.shippingState;
                          shippingPostcodeController.text =
                              result.shippingPostcode;
                          shippingCountryController.text =
                              result.shippingCountry;

                          selectedAddress = "تم حفظ البيانات بنجاح";
                        });

                        log(
                          "الاسم المحفوظ: ${result.firstName} ${result.lastName}",
                        );
                        log("الإيميل المحفوظ: ${result.email}");
                      }
                    },
                  ),

                  // عرض حالة البيانات
                  if (selectedAddress != null) ...[
                    SizedBox(height: 15.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withAlpha(15),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        selectedAddress!,
                        style: AppStyle.styleRegular14(
                          context,
                        ).copyWith(color: AppColors.primaryColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 30.h)),

          // باقي الكود زي ما هو...
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
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
                child: BlocConsumer<CreateOrderCubit, CreateOrderState>(
                  listener: (context, state) {
                    if (state is CreateOrderSuccess) {
                      Fluttertoast.showToast(
                        msg: state.order.message,
                        gravity: ToastGravity.TOP,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.sp,
                      );

                      GoRouter.of(context).push(
                        AppRouter.paymentWebPage,
                        extra: {
                          "checkoutUrl": state.order.data.stripeCheckoutUrl,
                          // "orderId": state.order.data.orderId,
                        },
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
                    // 🔥 هنا بنستمع لما الـ calculate ينتهي
                    if (state is CalculateShippingAddressSuccess) {
                      // بعد ما الـ calculate ينتهي، نعمل createOrder مباشرة
                      context.read<CreateOrderCubit>().createOrder(
                        shippingMethodModel: state.shippingMethods[0],
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
                      );
                    }
                    if (state is CalculateShippingAddressError) {
                      Fluttertoast.showToast(
                        msg:
                            ".. الرجاء التحقق من البيانات، حدث خطأ في حساب الشحن",
                        gravity: ToastGravity.TOP,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.sp,
                      );
                    }
                  },
                  builder: (context, state) {
                    double total = widget.cartList.fold(
                      0,
                      (sum, item) => sum + (item.totalPrice ?? 0),
                    );
                    return CustomElevatedButton(
                      verticalPadding: 4.h,
                      height: 60.h,
                      onPressed:
                          (state is CreateOrderLoading ||
                              state is CalculateShippingAddressLoading)
                          ? () {}
                          : () {
                              context
                                  .read<CreateOrderCubit>()
                                  .calculateShippingAddress(
                                    items: widget.cartList,
                                    shippingFirstName:
                                        shippingFirstNameController.text,
                                    shippingLastName:
                                        shippingLastNameController.text,
                                    shippingAddress1:
                                        shippingAddress1Controller.text,
                                    shippingAddress2:
                                        shippingAddress2Controller.text,
                                    shippingCity: shippingCityController.text,
                                    shippingState: shippingStateController.text,
                                    shippingPostcode:
                                        shippingPostcodeController.text,
                                    shippingCountry:
                                        shippingCountryController.text,
                                  );
                            },
                      child:
                          (state is CreateOrderLoading ||
                              state is CalculateShippingAddressLoading)
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Row(
                              children: [
                                Text(
                                  "تأكيد الدفع",
                                  style: AppStyle.styleRegular15(
                                    context,
                                  ).copyWith(color: Colors.white),
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  "${total.toStringAsFixed(2)} ",
                                  style: AppStyle.styleRegular15(
                                    context,
                                  ).copyWith(color: Colors.white),
                                ),
                              ],
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
