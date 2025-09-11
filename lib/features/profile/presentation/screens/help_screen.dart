import 'package:camion/config/widgets/custom_box_decoration.dart';
import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  Map<int, bool> expandedItems = {};

  @override
  Widget build(BuildContext context) {
    final List<FAQSection> faqSections = [
      FAQSection(
        title: S.of(context).Shipping_and_Delivery,
        questions: [
          FAQItem(
            question: S.of(context).question_1,
            answer: S.of(context).answer_1,
          ),
          FAQItem(
            question: S.of(context).question_2,
            answer: S.of(context).answer_2,
          ),
        ],
      ),
      FAQSection(
        title: S.of(context).Payments,
        questions: [
          FAQItem(
            question: S.of(context).question_3,
            answer: S.of(context).answer_3,
          ),
        ],
      ),
      FAQSection(
        title: S.of(context).Return_and_Exchange,
        questions: [
          FAQItem(
            question: S.of(context).question_4,
            answer: S.of(context).answer_4,
          ),
        ],
      ),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 15.h)),
          CustomSliverAppBar(
            appBarHeight: 70.h,
            title: Text(
              S.of(context).help,
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

          SliverToBoxAdapter(child: SizedBox(height: 15.h)),
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                // color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  ...faqSections.asMap().entries.map((entry) {
                    int sectionIndex = entry.key;
                    FAQSection section = entry.value;

                    return Container(
                      margin: EdgeInsets.only(bottom: 24.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Section Title
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                            child: Text(
                              section.title,
                              style: AppStyle.styleBold16(
                                context,
                              ).copyWith(color: AppColors.primaryColor),
                            ),
                          ),

                          // Questions
                          ...section.questions.asMap().entries.map((
                            questionEntry,
                          ) {
                            int questionIndex = questionEntry.key;
                            FAQItem item = questionEntry.value;
                            int globalIndex =
                                sectionIndex * 100 + questionIndex;
                            bool isExpanded =
                                expandedItems[globalIndex] ?? false;

                            return Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 4.h,
                              ),
                              decoration: getContainerBoxDecoration(),
                              child: Column(
                                children: [
                                  // Question
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        expandedItems[globalIndex] =
                                            !isExpanded;
                                      });
                                    },
                                    borderRadius: BorderRadius.circular(8.r),
                                    child: Padding(
                                      padding: EdgeInsets.all(16.w),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item.question,
                                              style:
                                                  AppStyle.styleSemiBold16(
                                                    context,
                                                  ).copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black87,
                                                  ),
                                            ),
                                          ),

                                          SizedBox(width: 12.w),

                                          Icon(
                                            isExpanded
                                                ? Icons.keyboard_arrow_up
                                                : Icons.keyboard_arrow_down,
                                            color: Colors.grey[600],
                                            size: 24.sp,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // Answer
                                  if (isExpanded)
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.fromLTRB(
                                        16.w,
                                        0,
                                        16.w,
                                        16.h,
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(16.w),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[50],
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                        ),
                                        child: Text(
                                          item.answer,
                                          style:
                                              AppStyle.styleRegular14(
                                                context,
                                              ).copyWith(
                                                color: Colors.black54,
                                                height: 1.5,
                                              ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    );
                  }),

                  // Contact Section
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).Direct_communication,
                          style: AppStyle.styleBold16(context).copyWith(
                            color: AppColors.primaryColor,
                          )
                        ),
                        SizedBox(height: 16.h),

                        // WhatsApp Contact
                        GestureDetector(
                          onTap: () async {
                            final phone = "+201158778592";
                            final url = Uri.parse("https://wa.me/$phone");

                            if (await canLaunchUrl(url)) {
                              await launchUrl(
                                url,
                                mode: LaunchMode.externalApplication,
                              );
                            } else {
                              Fluttertoast.showToast(
                                backgroundColor: Colors.red,
                                gravity: ToastGravity.TOP,
                                msg: "Unable to open WhatsApp",
                              );
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(16.w),
                            decoration: getContainerBoxDecoration(),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        S.of(context).Contact_us_via_WhatsApp,
                                        style: AppStyle.styleRegular14(context).copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        )
                                      ),
                                      Text(
                                        S.of(context).For_immediate_assistance,
                                        style: AppStyle.styleRegular10(context).copyWith(
                                          color: Colors.blue,
                                        )
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(width: 12.w),

                                Container(
                                  width: 32.w,
                                  height: 32.h,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  child: Icon(
                                    Icons.chat,
                                    color: Colors.white,
                                    size: 18.sp,
                                  ),
                                ),
                                SizedBox(width: 12.w),

                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey[400],
                                  size: 16.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Model Classes
class FAQSection {
  final String title;
  final List<FAQItem> questions;

  FAQSection({required this.title, required this.questions});
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}
