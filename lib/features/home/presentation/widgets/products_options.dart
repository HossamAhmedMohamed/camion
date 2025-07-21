import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductsSelectionOptions extends StatefulWidget {
  const ProductsSelectionOptions({super.key});

  @override
  State<ProductsSelectionOptions> createState() =>
      _ProductsSelectionOptionsState();
}

class _ProductsSelectionOptionsState extends State<ProductsSelectionOptions> {
  int counter = 1;
  List<bool> pieceSelections = List.filled(6, false);
  int selectedSize = 0;
  int selectedColor = -1;

  bool isSelectedPiece = false;
  List<int> sizes = [45, 44, 43, 42, 41, 40];
  List<Color> colors = [
    const Color(0xFF3F51B5),
    const Color(0xFF616161),
    const Color(0xFF212121),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Counter Section
        _buildCounterSection(),
    
        SizedBox(height: 30.h),
    
        // Pieces Section
        _buildPiecesSection(),
    
        SizedBox(height: 30.h),
    
        // Sizes Section
        _buildSizesSection(),
    
        SizedBox(height: 30.h),
    
        // Colors Section
        _buildColorsSection(),
      ],
    );
  }

  Widget _buildCounterSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'الكمية',
          style: AppStyle.styleRegular18(
            context,
          ).copyWith(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
              side: BorderSide(
                color: AppColors.primaryColor.withAlpha(40),
                width: 1.5.w,
              ),
            ),
            color: AppColors.primaryColor.withAlpha(15),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    counter++;
                  });
                },
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8E9E9),
                    borderRadius: BorderRadius.circular(50.r),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Icon(Icons.add, size: 20.sp),
                ),
              ),

              Container(
                width: 60.w,
                height: 40.h,
                margin: EdgeInsets.symmetric(horizontal: 10.w),

                child: Center(
                  child: Text(
                    '$counter',
                    style: AppStyle.styleBold18(
                      context,
                    ).copyWith(color: Colors.black),
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  if (counter > 1) {
                    setState(() {
                      counter--;
                    });
                  }
                },
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8E9E9),
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  child: Icon(Icons.remove, size: 20.sp),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPiecesSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double availableWidth = constraints.maxWidth;

        double itemMinWidth = 100;
        double spacing = 10.w;

        int itemsPerRow =
            ((availableWidth + spacing) / (itemMinWidth + spacing)).floor();
        itemsPerRow = itemsPerRow.clamp(2, 6);

        double itemWidth =
            (availableWidth - (spacing * (itemsPerRow - 1))) / itemsPerRow;

        return Wrap(
          spacing: spacing,
          runSpacing: 15.h,
          children: [
            _buildPieceItem(0, '2-6', 'قطعة', false, itemWidth),
            _buildPieceItem(1, '2-6', 'قطعة', false, itemWidth),
            _buildPieceItem(2, '2-6', 'قطعة', false, itemWidth),
            _buildPieceItem(3, '1', 'قطعة', false, itemWidth),
            _buildPieceItem(4, '2-6', 'قطعة', false, itemWidth),
            _buildPieceItem(5, '2-6', 'قطعة', false, itemWidth),
            _buildPieceItem(6, '2-6', 'قطعة', false, itemWidth),
          ],
        );
      },
    );
  }

  Widget _buildPieceItem(
    int index,
    String number,
    String text,
    bool isSelected,
    double itemWidth,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        width: itemWidth,

        padding: EdgeInsets.symmetric(horizontal: 3.w),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFE5E5) : Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected ? const Color(0xFFFF5252) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  number,
                  style: AppStyle.styleBold12(
                    context,
                  ).copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                ),

                SizedBox(width: 3.w),

                Text(
                  text,
                  style: AppStyle.styleRegular10(
                    context,
                  ).copyWith(color: AppColors.black),
                ),

                const Spacer(),
                Container(
                  width: 15.w,
                  height: 15.h,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFFF5252)
                        : Colors.transparent,
                    border: Border.all(
                      color: isSelected ? const Color(0xFFFF5252) : Colors.grey,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                  child: isSelected
                      ? Icon(Icons.check, size: 10.sp, color: Colors.white)
                      : null,
                ),

                // : Container(
                //     width: 15.w,
                //     height: 15.h,
                //     decoration: BoxDecoration(
                //       color: const Color(0xFFFF5252),
                //       borderRadius: BorderRadius.circular(3.r),
                //     ),
                //     child: Icon(
                //       Icons.check,
                //       size: 10.sp,
                //       color: Colors.white,
                //     ),
                //   ),
                SizedBox(width: 5.w),
              ],
            ),

            SizedBox(height: 3.h),

            Row(
              children: [
                Text(
                  '25',
                  style: AppStyle.styleRegular14(
                    context,
                  ).copyWith(color: AppColors.black),
                ),
                Text(
                  ' ريال ',
                  style: AppStyle.styleRegular10(
                    context,
                  ).copyWith(color: AppColors.black),
                ),

                SizedBox(width: 3.w),
                Text(
                  '35 ريال',
                  style: AppStyle.styleRegular10(context).copyWith(
                    color: AppColors.alertRed,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSizesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('المقاس', style: AppStyle.styleBold18(context)),

        SizedBox(height: 15.h),

        Row(children: sizes.map((size) => _buildSizeItem(size)).toList()),
      ],
    );
  }

  Widget _buildSizeItem(int size) {
    bool isSelected = selectedSize == size;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSize = size;
        });
      },
      child: Container(
        width: 45.w,
        height: 45.h,
        margin: EdgeInsets.only(left: 8.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected ? const Color(0xFFFF5252) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Center(
          child: Text(
            '$size',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: isSelected ? const Color(0xFFFF5252) : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColorsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('الألوان المتاحة', style: AppStyle.styleBold18(context)),

        SizedBox(height: 15.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            for (int i = 0; i < colors.length; i++)
              _buildColorItem(i, colors[i]),
          ],
        ),
      ],
    );
  }

  Widget _buildColorItem(int index, Color color) {
    bool isSelected = selectedColor == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = index;
        });
      },
      child: Container(
        width: 50.w,
        height: 50.h,
        margin: EdgeInsets.only(left: 10.w),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12.r),
          // border: isSelected ? Border.all(color: Colors.white, width: 3) : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(30),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: isSelected
            ? Icon(Icons.check, color: Colors.white, size: 24.sp)
            : null,
      ),
    );
  }
}
