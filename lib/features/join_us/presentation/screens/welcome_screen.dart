import 'package:camion/config/widgets/custom_elevated_button.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 26.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FittedBox(
              child: Text(
                "يشرفنا انضمامك لفريق مسوقينا",
                style: AppStyle.styleRegular14(
                  context,
                ).copyWith(color: Colors.black, fontWeight: FontWeight.w500),
              ),
            ),

            SizedBox(height: 6.h),

            Text(
              "نقدم نظام تسويق بالعمولة بسيط وفعّال، يعتمد على أكواد خاصة يحصل عليها كل مسوّق، بحيث يقدر يشاركها مع جمهوره ويكسب عمولة على كل عملية بيع تتم باستخدام الكود. العمولة بيتم تحويلها مباشرة إلى المحفظة بدون أي وسيط أو تأخير، لضمان سرعة وسهولة التحصيل. بنوفر مجموعة متنوعة من المنتجات في مجالات مختلفة، علشان كل مسوّق يلاقي اللي يناسب جمهوره ويحقق أعلى نسبة مبيعات. هدفنا إننا نساعدك تكسب دخل مستمر من خلال مجهود بسيط وتسويق ذكي.",
              style: AppStyle.styleRegular14(
                context,
              ).copyWith(color: Colors.black54, fontWeight: FontWeight.w400),
            ),

            SizedBox(height: 30.h),

            CustomElevatedButton(
              text: "ابدأ الآن",
              onPressed: () {
                GoRouter.of(context).push(AppRouter.joinUs);
              },
            ),
          ],
        ),
      ),
    );
  }
}
