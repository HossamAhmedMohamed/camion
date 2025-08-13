import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/config/widgets/custom_list_tile.dart';
import 'package:camion/config/widgets/expanded_row_for_user.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/profile/presentation/widgets/profile_sliver_app_bar.dart';
import 'package:camion/features/profile/presentation/widgets/wallet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MyWalletScreen extends StatelessWidget {
  const MyWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,

      body: CustomScrollView(
        slivers: [
          ProfileSliverAppBar(
            title: Text(
              "Wallet",
              style: AppStyle.styleRegular18(
                context,
              ).copyWith(color: AppColors.black, fontWeight: FontWeight.w500),
            ),
            isShoppingCartShown: false,
            leading: GestureDetector(
              onTap: () {
                GoRouter.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back,
                color: AppColors.black,
                size: 25.sp,
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 20.h)),

          const SliverToBoxAdapter(child: WalletCard(totalAmount: '100')),

          SliverToBoxAdapter(child: SizedBox(height: 40.h)),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomElevatedButton(
                onPressed: () {},
                widget: Image.asset(Assets.imagesRefresh),
                child: Text(
                  "Add Money",
                  style: AppStyle.styleRegular15(
                    context,
                  ).copyWith(color: Colors.white),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 30.h)),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: ExpandedRowForUserImplementation(
                // firstTitle: 'العمليات',
                secondTitle: 'All',
                onTapOnSecondTitle: () {},
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 30.h)),

          SliverList.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return const Column(
                children: [
                  CustomListTile(title: 'Transaction',),

                  Row(
                    children: [
                      Expanded(child: Divider(color: AppColors.paleGray)),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
