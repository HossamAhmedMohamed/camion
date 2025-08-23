import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ReviewContainer extends StatelessWidget {
  final String userName;
  final String reviewText;
  final DateTime reviewDate;
  final int rating;

  const ReviewContainer({
    super.key,
    required this.userName,
    required this.reviewText,
    required this.reviewDate,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(50),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.withAlpha(50), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with name, date and profile icon
          Row(
             
            children: [
              Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.person, color: Colors.black, size: 18.sp),
              ),

              SizedBox(width: 6.w),
              Text(
                '$userName - ${DateFormat('MMM dd, yyyy').format(reviewDate)}',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Review text
          Text(
            reviewText.replaceAll(RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true), ''),
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black87,
               
            ),
          ),

          SizedBox(height: 8.h),

          // Star rating
          Row(
            children: List.generate(5, (index) {
              return Icon(
                Icons.star,
                color: index < rating
                    ? const Color(0xFFFFB400)
                    : Colors.grey[300],
                size: 20.sp,
              );
            }),
          ),
        ],
      ),
    );
  }
}
