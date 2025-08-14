import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class WalletCard extends StatelessWidget {
  final String totalAmount;
  final String currency;
  final String cardType;
  final Color cardColor;
  final String? bankLogo;

  const WalletCard({
    super.key,
    required this.totalAmount,
    this.currency = '\$',
    this.cardType = 'C',
    this.cardColor = const Color(0xFFB71C1C),
    this.bankLogo,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      height: screenWidth > 800 ? 260.h : 200.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFB92123), Color(0xFF451819)],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.gray.withAlpha(100),
            spreadRadius: 1,
            blurRadius: 4.r,
            offset: Offset(0, 10.h),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            child: Image.asset(
              width: screenWidth*0.75,
              Assets.imagesWalletRectangle, fit: BoxFit.fill),
          ),

          Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  "Total Money",
                  style: AppStyle.styleRegular18(
                    context,
                  ).copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                ),

                // NFC Icon
                SizedBox(height: 20.h),

                Text(
                  "$currency$totalAmount",
                  style: AppStyle.styleRegular25(context).copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            right: 24.w,
            bottom: 20.h,
            child: Image.asset(
              Assets.imagesWalletCode,
              width: 50.w,
              height: 50.h,
            ),
          ),

          Positioned(
            left: screenWidth * 0.3,
            bottom: 30.h,
            child: SvgPicture.asset(
              Assets.imagesWalletWifi,
              width: 30.w,
              height: 30.h,
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            left: 10,
            bottom: 10.h,
            child: Image.asset(
              Assets.imagesCamionLogoWhite,
              width: 30.w,
              height: 30.h,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

 
