import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/core/utils/app_images.dart';
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
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            const CartSliverAppBar(title: "العربة", isShoppingCart: true),
            SliverToBoxAdapter(child: SizedBox(height: 20.h)),

            SliverList.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const ProductCartItem(
                  imageUrl: Assets.imagesVasline,
                  title: 'غطاء حماية للايفون 16 برو  ',
                  price: 150,
                  initialQuantity: 5,
                );
              },
            ),
            SliverToBoxAdapter(child: SizedBox(height: 120.h)),
          ],
        ),

        Positioned(
          bottom: 10.h,
          left: 16.w,
          right: 16.w,
          child: CustomElevatedButton(
            text: "المتابعة لدفع الكل        \$200",
            onPressed: () {
              GoRouter.of(context).push(AppRouter.confirmPayment);
            },
          ),
        ),
      ],
    );
  }
}
