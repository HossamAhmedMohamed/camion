import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/home/data/models/all_products_model/sub_models/attribute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductsSelectionOptions extends StatefulWidget {
  const ProductsSelectionOptions({super.key, required this.attributes, this.onSelectionChanged});
  final List<Attribute> attributes;
  final Function(Map<String, String> attributes, int quantity)? onSelectionChanged;

  @override
  State<ProductsSelectionOptions> createState() =>
      _ProductsSelectionOptionsState();
}

class _ProductsSelectionOptionsState extends State<ProductsSelectionOptions> {
  int counter = 1;
  Map<String, String> selectedAttributes = {};

  void _updateSelection(String attrName, String termName) {
    setState(() {
      selectedAttributes[attrName] = termName;
    });
    _notifyParent();
  }

  void _updateCounter(int value) {
    setState(() {
      counter = value;
    });
    _notifyParent();
  }

  void _notifyParent() {
    widget.onSelectionChanged?.call(selectedAttributes, counter);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCounterSection(),
        SizedBox(height: 30.h),
        buildAttributesSections(),
      ],
    );
  }

  Widget buildAttributesSections() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.attributes.map((attr) {
        final String attrName = attr.name;
        final List<AttributeTerm> terms = attr.terms;

        // عرض الألوان الفعلية فقط
        if (attrName.toLowerCase() == 'color' || attrName == 'اللون' || attrName.toLowerCase().contains('color')) {
          final List<AttributeTerm> colorTerms =
              terms.where((t) => getColorFromNameOrHex(t.name) != null).toList();

          if (colorTerms.isEmpty) {
            return const SizedBox.shrink(); // مفيش ألوان فعلية
          }

          return _buildAttributeSection(attrName, colorTerms, isColor: true);
        }

        // عرض المقاسات فقط بدون وصف
        if (attrName.toLowerCase() == 'size' || attrName == 'المقاس') {
          final cleanedTerms = terms.map((t) {
            String cleanName = t.name;
            if (cleanName.contains('[')) {
              cleanName = cleanName.split('[').first.trim();
            } else {
              cleanName = cleanName.split(' ').first.trim();
            }
            return AttributeTerm(
              id: t.id,
              name: cleanName,
              slug: t.slug,
            );
          }).toList();

          return _buildAttributeSection(attrName, cleanedTerms);
        }

        // أي Attribute تاني
        return _buildAttributeSection(attrName, terms);
      }).toList(),
    );
  }

  Widget _buildAttributeSection(
    String attrName,
    List<AttributeTerm> terms, {
    bool isColor = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(attrName,
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 15.h),
        Wrap(
          spacing: 8.w,
          children: terms.map((term) {
            final String termName = term.name;
            final bool isSelected = selectedAttributes[attrName] == termName;

            final color = isColor ? getColorFromNameOrHex(termName) : null;

            return GestureDetector(
              onTap: () => _updateSelection(attrName, termName),
              child: color != null
                  ? buildColorBox(color, isSelected)
                  : buildTextBox(termName, isSelected),
            );
          }).toList(),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  final Map<String, Color> colorMap = {
    "black": Colors.black,
    "white": Colors.white,
    "red": Colors.red,
    "blue": Colors.blue,
    "green": Colors.green,
    "pink": Colors.pink,
    "yellow": Colors.yellow,
    "purple": Colors.purple,
    "orange": Colors.orange,
    "grey": Colors.grey,
    "gray": Colors.grey,
    "brown": Color(0xFFA52A2A),
    "navy": Color(0xFF000080),
  };

  Color? getColorFromNameOrHex(String colorName) {
    final lower = colorName.toLowerCase().trim();

    // نحاول نقطع النص لجزء اللون فقط
    String firstPart = lower;
    if (firstPart.contains('+')) {
      firstPart = firstPart.split('+').first.trim();
    }
    if (firstPart.contains('[')) {
      firstPart = firstPart.split('[').first.trim();
    }
    if (firstPart.contains(' ')) {
      // ناخد أول كلمة بس لو فيه وصف طويل
      firstPart = firstPart.split(' ').first.trim();
    }

    // لو موجودة في الماب
    if (colorMap.containsKey(firstPart)) {
      return colorMap[firstPart];
    }

    // لو Hex
    if (firstPart.startsWith('#') &&
        (firstPart.length == 7 || firstPart.length == 9)) {
      try {
        return Color(int.parse(firstPart.substring(1), radix: 16) + 0xFF000000);
      } catch (_) {}
    }

    return null;
  }

  Widget buildColorBox(Color color, bool isSelected) {
    return Container(
      width: 45.w,
      height: 45.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isSelected ? Colors.black : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: isSelected
          ? Icon(Icons.check,
              color: color == Colors.white ? Colors.black : Colors.white)
          : null,
    );
  }

  Widget buildTextBox(String text, bool isSelected) {
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
          color: isSelected ? Colors.white : Colors.black,
          fontSize: 14.sp,
        ),
      ),
    );
  }

  Widget _buildCounterSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'الكمية',
          style: AppStyle.styleRegular18(context).copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
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
                onTap: () => _updateCounter(counter + 1),
                child: _buildCounterButton(Icons.add),
              ),
              Container(
                width: 60.w,
                height: 40.h,
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                child: Center(
                  child: Text(
                    '$counter',
                    style: AppStyle.styleBold18(context)
                        .copyWith(color: Colors.black),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (counter > 1) {
                    _updateCounter(counter - 1);
                  }
                },
                child: _buildCounterButton(Icons.remove),
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
