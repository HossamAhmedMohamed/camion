import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key, required this.title, this.subtitle, this.trailing, this.leading,
  });

  final String title;
  final Widget? subtitle;
  final Widget? trailing;
  final Widget? leading;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w ),
      leading: leading ,
      title: Text(
         title,
        style: AppStyle.styleRegular14(
          context,
        ).copyWith(color: AppColors.black),
      ),
    
      subtitle: subtitle ?? Row(
        children: [
          SvgPicture.asset(
            Assets.imagesCalendar,
            width: 20.w,
            height: 20.h,
          ),
          SizedBox(width: 5.w),
          Text(
            "01/01/2023",
            style: AppStyle.styleRegular14(
              context,
            ).copyWith(color: AppColors.gray),
          ),
        ],
      ),
    
      trailing: trailing ?? Text(
        "\$100",
        style: AppStyle.styleBold18(
          context,
        ).copyWith(color: const Color(0xFF244643)),
      ),
    );
  }
}
