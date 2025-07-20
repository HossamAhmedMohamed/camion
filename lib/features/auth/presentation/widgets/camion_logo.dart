import 'package:camion/core/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CamionLogo extends StatelessWidget {
  const CamionLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(Assets.imagesCamionLogo, width: 140.w, height: 105.h);
  }
}
