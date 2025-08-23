import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/home/data/models/all_products_model/sub_models/product_variations.dart';
import 'package:camion/features/home/presentation/widgets/color_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductsSelectionOptions extends StatefulWidget {
  const ProductsSelectionOptions({
    super.key,
    required this.variations,
    this.onSelectionChanged,
  });
  
  final List<ProductVariations> variations;
  final Function(Map<String, String> selectedVariation, int quantity, ProductVariations? matchedVariation )?
      onSelectionChanged;

  @override
  State<ProductsSelectionOptions> createState() =>
      _ProductsSelectionOptionsState();
}

class _ProductsSelectionOptionsState extends State<ProductsSelectionOptions> {
  int counter = 1;
  Map<String, String> selectedAttributes = {};
  ProductVariations? selectedVariation;

  @override
  void initState() {
    super.initState();
    // تهيئة أول variation إذا كانت متاحة
    // if (widget.variations.isNotEmpty) {
    //   _selectVariation(widget.variations.first);
    // }
  }

  // void _selectVariation(ProductVariations variation) {
  //   setState(() {
  //     selectedVariation = variation;
  //     selectedAttributes.clear();
  //     // تحديث الخصائص المحددة بناءً على ال variation المختار
  //     for (var attr in variation.attributes) {
  //       selectedAttributes[attr.name] = attr.option;
  //     }
  //   });
  //   _notifyParent();
  // }

  void _updateSelection(String attrName, String option) {
    setState(() {
      selectedAttributes[attrName] = option;
    });
    
     
    final matchingVariation = _findMatchingVariation();
    if (matchingVariation != null) {
      selectedVariation = matchingVariation;
    }
    
    _notifyParent();
  }

  ProductVariations? _findMatchingVariation() {
    for (var variation in widget.variations) {
      bool matches = true;
      
      // التحقق من تطابق جميع الخصائص المحددة
      for (var attr in variation.attributes) {
        if (selectedAttributes[attr.name] != attr.option) {
          matches = false;
          break;
        }
      }
      
      // التحقق من أن جميع الخصائص المطلوبة محددة
      if (matches && selectedAttributes.length == variation.attributes.length) {
        return variation;
      }
    }
    return null;
  }

  void _updateCounter(int value) {
    setState(() {
      counter = value;
    });
    _notifyParent();
  }

  void _notifyParent() {
    // إرسال الـ variation المطابق للـ parent
    widget.onSelectionChanged?.call(selectedAttributes, counter, selectedVariation);
  }


   
  Map<String, Set<String>> _getAvailableAttributes() {
    Map<String, Set<String>> attributes = {};
    
    for (var variation in widget.variations) {
      for (var attr in variation.attributes) {
        if (!attributes.containsKey(attr.name)) {
          attributes[attr.name] = <String>{};
        }
        attributes[attr.name]!.add(attr.option);
      }
    }
    
    return attributes;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCounterSection(),
        SizedBox(height: 20.h),
        // _buildSelectedVariationInfo(),
        SizedBox(height: 20.h),
        _buildAttributesSections(),
      ],
    );
  }

   

  Widget _buildAttributesSections() {
    final availableAttributes = _getAvailableAttributes();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: availableAttributes.entries.map((entry) {
        final String attrName = entry.key;
        final List<String> options = entry.value.toList();

        if (attrName.toLowerCase() == 'color' || attrName.toLowerCase().contains('color')) {
          return _buildAttributeSection(attrName, options, isColor: true);
        }

        return _buildAttributeSection(attrName, options);
      }).toList(),
    );
  }

  bool _isOptionAvailable(String attrName, String option) {
    Map<String, String> tempAttributes = Map.from(selectedAttributes);
    tempAttributes[attrName] = option;
    
    for (var variation in widget.variations) {
      if (variation.stockStatus != 'instock') continue;
      
      bool matches = true;
      for (var attr in variation.attributes) {
        if (tempAttributes.containsKey(attr.name) && 
            tempAttributes[attr.name] != attr.option) {
          matches = false;
          break;
        }
      }
      if (matches) return true;
    }
    return false;
  }

  // استخدام ColorDetectionService بدلاً من الدالة القديمة
  Color? getColorFromNameOrHex(String colorName) {
    // محاولة الحصول على اللون من النص باستخدام ColorDetectionService
    Color? detectedColor = ColorDetectionService.getColorFromText(colorName);
    
    if (detectedColor != null) {
      return detectedColor;
    }
    
    // التحقق من hex colors كما كان من قبل
    final lower = colorName.toLowerCase().trim();
    if (lower.startsWith('#') && (lower.length == 7 || lower.length == 9)) {
      try {
        return Color(int.parse(lower.substring(1), radix: 16) + 0xFF000000);
      } catch (_) {}
    }
    
    // إرجاع لون افتراضي بناءً على النص
    return ColorDetectionService.getDefaultColorByIndex(colorName.hashCode.abs());
  }

  Widget _buildAttributeSection(
    String attrName,
    List<String> options, {
    bool isColor = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          attrName,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 15.h),
        Wrap(
          spacing: 8.w,
          children: options.map((option) {
            final bool isSelected = selectedAttributes[attrName] == option;
            final bool isAvailable = _isOptionAvailable(attrName, option);
            
            // الحصول على اللون باستخدام الخدمة الجديدة
            final color = isColor ? getColorFromNameOrHex(option) : null;

            return GestureDetector(
              onTap: isAvailable ? () => _updateSelection(attrName, option) : null,
              child: Opacity(
                opacity: isAvailable ? 1.0 : 0.5,
                child: color != null
                    ? buildColorBox(color, isSelected, option) // إضافة النص كمعامل
                    : buildTextBox(option, isSelected, isAvailable),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  // تحسين buildColorBox لإظهار النص أيضاً
  Widget buildColorBox(Color color, bool isSelected, String colorName) {
    return Column(
      children: [
        Container(
          width: 45.w,
          height: 45.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.black54  ,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: isSelected
              ? Icon(
                  Icons.check,
                  color: _getContrastColor(color),
                  size: 20.sp,
                )
              : null,
        ),

        // SizedBox(height: 5.h),
        // SizedBox(
        //   width: 45.w,
        //   child: Text(
        //     maxLines: 2,
        //     overflow: TextOverflow.ellipsis,
        //     colorName,
        //     style: TextStyle(
        //       fontSize: 12.sp,
        //       color: isSelected ? Colors.black : Colors.grey,
        //     ),
        //   ),
        // ),
      ],
    );
  }

  // دالة مساعدة للحصول على لون متباين للنص
  Color _getContrastColor(Color color) {
    // حساب السطوع
    double brightness = (color.red * 299 + color.green * 587 + color.blue * 114) / 1000;
    return brightness > 128 ? Colors.black : Colors.white;
  }

  Widget buildTextBox(String text, bool isSelected, bool isAvailable) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFFF5252) : Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: isSelected ? const Color(0xFFFF5252) : Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : (isAvailable ? Colors.black : Colors.grey),
          fontSize: 14.sp,
        ),
      ),
    );
  }

  Widget _buildCounterSection() {
    int maxQuantity = selectedVariation?.stockQuantity ?? 100;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Quantity',
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
                  if (counter > 1) {
                    _updateCounter(counter - 1);
                  }
                },
                child: _buildCounterButton(Icons.remove),
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
                  if (counter < maxQuantity) {
                    _updateCounter(counter + 1);
                  }
                },
                child: _buildCounterButton(Icons.add),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCounterButton(IconData icon) {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        color: const Color(0xFFF8E9E9),
        borderRadius: BorderRadius.circular(50.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Icon(icon, size: 20.sp),
    );
  }
}