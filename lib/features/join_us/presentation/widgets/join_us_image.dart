import 'package:camion/core/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JooinUsImage extends StatelessWidget {
  const JooinUsImage({super.key, required this.screenWidth, this.image});

  final double screenWidth;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 150.h,
        width: screenWidth,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child:
                  
                  Image.asset(
                    Assets.imagesPhotoJoinUs,
                    height: 150.h,
                    width: 150.w,
                    fit: BoxFit.contain,
                  ),
            ),

            Positioned(
              bottom: 0,
              left: screenWidth * 0.5,
              child: Container(
                padding: EdgeInsets.all(4.r),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  color: Colors.white,
                ),
                child: SvgPicture.asset(
                  width: 18.w,
                  height: 18.h,
                  image ?? Assets.imagesCamera,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
