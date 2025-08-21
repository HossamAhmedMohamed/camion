import 'package:camion/config/widgets/custom_box_decoration.dart';
import 'package:camion/config/widgets/custom_sliver_app_bar.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
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

  final List<FAQSection> faqSections = [
    FAQSection(
      title: "Shipping and Delivery",
      questions: [
        FAQItem(
          question:
              "How long is the delivery time and what are the coverage areas?",
          answer:
              "Delivery typically takes 3 to 5 business days within major cities in Saudi Arabia. Shipments to remote areas may take longer. We are currently working to expand our services to cover all regions as soon as possible",
        ),
        FAQItem(
          question: "How can I track my order?",
          answer:
              "Once your order has shipped, you'll receive a notification and an email containing a tracking number. You can use this number to track your order directly on the shipping company's website. You can also check your order status through the My Orders section of your account.",
        ),
      ],
    ),
    FAQSection(
      title: "Payments",
      questions: [
        FAQItem(
          question: "What payment methods are available?",
          answer:
              "We accept payments via credit cards, Mada, Apple Pay, and cash on delivery",
        ),
      ],
    ),
    FAQSection(
      title: "Return and Exchange",
      questions: [
        FAQItem(
          question: "What is the return policy?",
          answer:
              "Products can be returned within 14 days from the date of receipt, provided they are in their original condition.",
        ),
      ],
    ),
  ];

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
              "Help",
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
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.red[600],
                              ),
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
                                              style: TextStyle(
                                                fontSize: 16.sp,
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
                                          style: TextStyle(
                                            fontSize: 14.sp,
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
                          "Direct communication",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[600],
                          ),
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
                                        "Contact us via WhatsApp",
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      Text(
                                        "For immediate assistance",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.blue,
                                        ),
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
