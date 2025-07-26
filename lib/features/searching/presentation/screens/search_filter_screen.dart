import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/home/presentation/widgets/home_sliver_appbar.dart';
import 'package:camion/features/home/presentation/widgets/search_bar.dart';
import 'package:camion/features/searching/presentation/widgets/get_filters_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchFilterScreen extends StatelessWidget {
  const SearchFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          const HomeSliverAppBar(),
          const SearchBarHome(),

          SliverToBoxAdapter(child: SizedBox(height: 20.h)),
          SliverList.builder(
            itemCount: getFilters(context).length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: getFilters(context)[index].onTap,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 26.w),
                
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              getFilters(context)[index].title,
                              style: AppStyle.styleRegular14(
                                context,
                              ).copyWith(color: AppColors.black),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.primaryColor,
                            size: 20.sp,
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                
                      const Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: AppColors.paleGray,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }


}
