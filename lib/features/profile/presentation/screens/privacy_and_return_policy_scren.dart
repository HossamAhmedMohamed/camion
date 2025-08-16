import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PrivacyAndReturnPolicyScren extends StatelessWidget {
  const PrivacyAndReturnPolicyScren({super.key});

  Widget buildPolicySection(
    BuildContext context,
    String title,
    List<String> points,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyle.styleBold20(
              context,
            ).copyWith(color: AppColors.black),
          ),
          SizedBox(height: 10.h),
          ...points.map(
            (point) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Text(
                "• $point",
                style: AppStyle.styleRegular16(
                  context,
                ).copyWith(color: AppColors.black),
              ),
            ),
          ),
        ],
      ),
    );
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
              "Privacy and Return Policy",
              style: AppStyle.styleRegular18(
                context,
              ).copyWith(color: AppColors.black, fontWeight: FontWeight.w500),
            ),
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
            actions: const [],
          ),
          SliverToBoxAdapter(child: SizedBox(height: 20.h)),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Policies - Camion App",
                    style: AppStyle.styleBold20(
                      context,
                    ).copyWith(color: AppColors.black),
                  ),
                  SizedBox(height: 20.h),

                  // Terms of Use
                  buildPolicySection(context, "1. Terms of Use", [
                    "By using Camion, you agree to comply with all the terms and conditions stated in this policy.",
                    "Camion reserves the right to update or modify these policies at any time. Users will be notified of any changes via the app or email.",
                    "The app must not be used for any illegal activities or in violation of local or international laws.",
                  ]),

                  // Product Policy
                  buildPolicySection(context, "2. Product Policy", [
                    "All products listed on Camion are original and match the specifications described on the product page.",
                    "Prices include VAT (if applicable) and do not include shipping fees unless otherwise stated.",
                    "Product colors may slightly vary due to screen settings or manufacturing differences.",
                  ]),

                  // Payment Policy
                  buildPolicySection(context, "3. Payment Policy", [
                    "Camion supports multiple payment methods (credit/debit cards, bank transfer, e-wallets, and cash on delivery if available).",
                    "All payments are secured through certified payment service providers.",
                    "If a payment fails, the order will not be confirmed, and the user may retry using a different method.",
                  ]),

                  // Shipping & Delivery Policy
                  buildPolicySection(context, "4. Shipping & Delivery Policy", [
                    "Camion provides worldwide shipping through trusted international courier services.",
                    "Delivery time varies depending on the destination country and shipping provider.",
                    "Customers will receive a tracking number once their order has been dispatched.",
                    "Camion is not responsible for delays caused by customs, natural events, or courier issues beyond our control.",
                  ]),

                  // Return & Refund Policy
                  buildPolicySection(context, "5. Return & Refund Policy", [
                    "Customers may request a return within 14 days of receiving the order, provided the item is unused, undamaged, and in its original packaging.",
                    "Certain items such as personal care products, food, or customized items are non-returnable.",
                    "Refunds will be processed to the original payment method within 7–14 business days after the returned item is inspected.",
                    "Shipping fees are non-refundable, and return shipping costs are the responsibility of the customer (unless the item is defective or incorrect).",
                  ]),

                  // Privacy Policy
                  buildPolicySection(context, "6. Privacy Policy", [
                    "Camion respects and protects your personal data.",
                    "We collect information (such as name, address, contact details, and payment info) only to process orders and improve user experience.",
                    "Personal data will never be sold or shared with third parties, except with shipping and payment partners to complete your order.",
                    "All data is securely stored, and users have the right to request access, correction, or deletion of their personal information.",
                  ]),

                  // Limitation of Liability
                  buildPolicySection(context, "7. Limitation of Liability", [
                    "Camion is not liable for any indirect, incidental, or consequential damages arising from the use of the app or purchased products.",
                    "Responsibility for product usage lies with the customer.",
                    "In case of disputes, Camion’s liability is limited to the order value only.",
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
