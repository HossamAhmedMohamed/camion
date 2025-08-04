import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/cart/presentation/widgets/cart_sliver_app_bar.dart';
import 'package:camion/features/cart/presentation/widgets/custom_product_to_cart.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: 6.h)),
              const CartSliverAppBar(title: "العربة"),
              SliverToBoxAdapter(child: SizedBox(height: 20.h)),

              SliverList.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const ProductCartItem(
                    imageUrl: Assets.imagesShoes,
                    title: 'سويت شيرت بسحاب كم طويل بياقة للرجال ',
                    description: "تحصل عليه الثلاثاء 30 سبتمر",
                    price: 150,
                    initialQuantity: 5,
                  );
                },
              ),
              SliverToBoxAdapter(child: SizedBox(height: 120.h)),
            ],
          ),
        ),

        _buildCheckoutSection(context),
      ],
    );
  }

  Widget _buildCheckoutSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return AspectRatio(
      aspectRatio: screenWidth > 800 ?  screenWidth / 260.h: screenWidth / 200.h,
      child: Container(
        // height: 220.h,
        decoration: const BoxDecoration(color: Colors.white),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "اجمالي",
                          style: AppStyle.styleRegular14(context).copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "90",
                          style: AppStyle.styleRegular14(context).copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                
                    SizedBox(height: 10.h),
                
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "التوصيل",
                          style: AppStyle.styleRegular14(context).copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "10",
                          style: AppStyle.styleRegular14(context).copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                
                    SizedBox(height: 10.h),
                
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "اجمالي الكل",
                          style: AppStyle.styleRegular14(context).copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "100",
                          style: AppStyle.styleRegular14(context).copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                
                    SizedBox(height: 10.h),
                  ],
                ),
              ),

              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w),

                  child: CustomElevatedButton(
                    height: 50.h,
                    padding: 0,
                     child: Text("المتابعة للدفع",   style: AppStyle.styleRegular15(
                          context,
                        ).copyWith(color: Colors.white),),
                    onPressed: () {
                      GoRouter.of(context).push(AppRouter.confirmPayment);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
