import 'package:camion/config/widgets/custom_selecting_method.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:camion/features/join_us/presentation/logic/cubit/toggle_join_us_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectingMaleOrFemale extends StatelessWidget {
  const SelectingMaleOrFemale({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ToggleJoinUsCubit, ToggleJoinUsState, int>(
      selector: (state) {
        return state.index;
      },
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: CustomSelectingMethods(
                onTap: () {
                  context.read<ToggleJoinUsCubit>().toggle(0);
                },
                logo: state == 0
                    ? Assets.imagesActiveMale
                    : Assets.imagesInActiveMale,
                text: "ذكر",
                textColor: state == 0
                    ? AppColors.primaryColor
                    : null,
                backgroundColor: state == 0
                    ? AppColors.primaryColor.withAlpha(15)
                    : Colors.white,
                borderColor: state == 0
                    ? AppColors.primaryColor
                    : null,
              ),
            ),
    
            SizedBox(width: 10.w),
    
            Expanded(
              child: CustomSelectingMethods(
                onTap: () {
                  context.read<ToggleJoinUsCubit>().toggle(1);
                },
                logo: state == 1
                    ? Assets.imagesActiveFemale
                    : Assets.imagesInactiveFemale,
                text: "أنثى",
                textColor: state == 1
                    ? AppColors.primaryColor
                    : null,
                backgroundColor: state == 1
                    ? AppColors.primaryColor.withAlpha(15)
                    : Colors.white,
                borderColor: state == 1
                    ? AppColors.primaryColor
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}
