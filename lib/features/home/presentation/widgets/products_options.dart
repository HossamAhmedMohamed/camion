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
  final Function(
    Map<String, String> selectedVariation,
    int quantity,
    ProductVariations? matchedVariation,
  )?
  onSelectionChanged;

  @override
  State<ProductsSelectionOptions> createState() =>
      _ProductsSelectionOptionsState();
}

class _ProductsSelectionOptionsState extends State<ProductsSelectionOptions> {
  int counter = 1;
  Map<String, String> selectedAttributes = {};
  ProductVariations? selectedVariation;
  String? selectedImageUrl;
  bool _imageSelectedManually = false;

  @override
  void initState() {
    super.initState();
  }

  void _updateSelection(String attrName, String option) {
    setState(() {
      selectedAttributes[attrName] = option;
    });

    // بس نحدث الصورة إذا مكانتش اتختارت يدوياً
    if (!_imageSelectedManually) {
      if (attrName.toLowerCase() == 'color' ||
          attrName.toLowerCase().contains('color')) {
        final matchingVariation = _findMatchingVariationByColor(option);
        if (matchingVariation != null) {
          selectedVariation = matchingVariation;
          selectedImageUrl = matchingVariation.image;
        }
      } else {
        final matchingVariation = _findMatchingVariation();
        if (matchingVariation != null) {
          selectedVariation = matchingVariation;
          selectedImageUrl = matchingVariation.image;
        }
      }
    } else {
      // حتى لو الصورة اتختارت يدوياً، لازم نحدث selectedVariation بناءً على الاختيارات الحالية
      final matchingVariation = _findMatchingVariation();
      if (matchingVariation != null) {
        selectedVariation = matchingVariation;
      }
    }

    _notifyParent();
  }

  void _selectImageVariation(ProductVariations variation) {
    setState(() {
      selectedVariation = variation;
      selectedImageUrl = variation.image;
      _imageSelectedManually = true; // نعين إن الصورة اتختارت يدوياً

      // تحديث الـ color/specs attributes بناءً على الصورة المختارة
      for (var attr in variation.attributes) {
        if (attr.name.toLowerCase().contains('color') ||
            attr.name.toLowerCase().contains('specs')) {
          selectedAttributes[attr.name] = attr.option;
        }
      }

      // التأكد من أن الـ size المختار متوفر مع هذا اللون/specs الجديد
      String? currentSize = selectedAttributes['size'];
      if (currentSize != null) {
        bool sizeAvailableWithNewColor = _isSizeAvailableWithSelectedColor(currentSize);
        
        // إذا الـ size مش متوفر مع اللون الجديد، نشيله من الاختيار
        if (!sizeAvailableWithNewColor) {
          selectedAttributes.remove('size');
        }
      }
    });

    _notifyParent();
  }

// دالة جديدة للتحقق من توفر الـ size مع اللون المختار
bool _isSizeAvailableWithSelectedColor(String size) {
  // نجيب اللون/specs المختار حالياً
  String? selectedColorOrSpecs;
  for (var key in selectedAttributes.keys) {
    if (key.toLowerCase().contains('color') ||
        key.toLowerCase().contains('specs')) {
      selectedColorOrSpecs = selectedAttributes[key];
      break;
    }
  }

  if (selectedColorOrSpecs == null) return true;

  // ندور في كل الـ variations نشوف في variation يحتوي على الـ size والـ color/specs معاً
  for (var variation in widget.variations) {
    if (variation.stockStatus != 'instock') continue;

    bool hasSize = false;
    bool hasColorOrSpecs = false;

    for (var attr in variation.attributes) {
      if (attr.name == 'size' && attr.option == size) {
        hasSize = true;
      }
      if ((attr.name.toLowerCase().contains('color') ||
           attr.name.toLowerCase().contains('specs')) &&
          attr.option == selectedColorOrSpecs) {
        hasColorOrSpecs = true;
      }
    }

    // إذا لقينا variation يحتوي على الاتنين، يبقى الـ size متوفر
    if (hasSize && hasColorOrSpecs) {
      return true;
    }
  }

  return false;
}

// تعديل دالة _isOptionAvailable لتتعامل مع الـ size بشكل صحيح


  ProductVariations? _findMatchingVariationByColor(String colorOption) {
    for (var variation in widget.variations) {
      if (variation.stockStatus != 'instock') continue;

      for (var attr in variation.attributes) {
        if ((attr.name.toLowerCase() == 'color' ||
                attr.name.toLowerCase().contains('color')) &&
            attr.option == colorOption) {
          return variation;
        }
      }
    }
    return null;
  }

  ProductVariations? _findMatchingVariation() {
    for (var variation in widget.variations) {
      bool matches = true;

      for (var attr in variation.attributes) {
        if (selectedAttributes[attr.name] != attr.option) {
          matches = false;
          break;
        }
      }

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
    widget.onSelectionChanged?.call(
      selectedAttributes,
      counter,
      selectedVariation,
    );
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

  // دالة لاستخراج الصور الفريدة
  // دالة لاستخراج الصور الفريدة بناءً على اللون أو الـ specs
  List<ProductVariations> _getUniqueImageVariations() {
    final Map<String, ProductVariations> uniqueVariations = {};

    for (var variation in widget.variations) {
      if (variation.stockStatus == 'instock' &&
          variation.image != null &&
          variation.image!.isNotEmpty) {
        // البحث عن attribute اللون أو الـ specs
        String? colorOrSpecs;
        for (var attr in variation.attributes) {
          if (attr.name.toLowerCase().contains('color') ||
              attr.name.toLowerCase().contains('specs')) {
            colorOrSpecs = attr.option;
            break;
          }
        }

        // إذا لم نجد color أو specs، نستخدم رابط الصورة كـ key
        String key = colorOrSpecs ?? variation.image!;

        // إذا لم نرَ هذا اللون/specs من قبل، نضيفه
        if (!uniqueVariations.containsKey(key)) {
          uniqueVariations[key] = variation;
        }
      }
    }

    return uniqueVariations.values.toList();
  }

  bool _shouldShowImages() {
    final availableAttributes = _getAvailableAttributes();
    final hasColorOrSpecs = availableAttributes.keys.any(
      (key) =>
          key.toLowerCase().contains('color') ||
          key.toLowerCase().contains('specs'),
    );

    // إذا كان هناك size فقط، أو color/specs، نعرض الصور
    return availableAttributes.containsKey('size') || hasColorOrSpecs;
  }

  bool _isOptionAvailable(String attrName, String option) {
  // للـ size، نتأكد إنه متوفر مع اللون/specs المختار حالياً
  if (attrName.toLowerCase() == 'size') {
    String? selectedColorOrSpecs;
    for (var key in selectedAttributes.keys) {
      if (key.toLowerCase().contains('color') ||
          key.toLowerCase().contains('specs')) {
        selectedColorOrSpecs = selectedAttributes[key];
        break;
      }
    }

    // إذا مفيش لون مختار بعد، كل الـ sizes متوفرة
    if (selectedColorOrSpecs == null) {
      for (var variation in widget.variations) {
        if (variation.stockStatus != 'instock') continue;
        for (var attr in variation.attributes) {
          if (attr.name == 'size' && attr.option == option) {
            return true;
          }
        }
      }
      return false;
    }

    // نتأكد إن الـ size متوفر مع اللون المختار
    for (var variation in widget.variations) {
      if (variation.stockStatus != 'instock') continue;

      bool hasSize = false;
      bool hasColorOrSpecs = false;

      for (var attr in variation.attributes) {
        if (attr.name == 'size' && attr.option == option) {
          hasSize = true;
        }
        if ((attr.name.toLowerCase().contains('color') ||
             attr.name.toLowerCase().contains('specs')) &&
            attr.option == selectedColorOrSpecs) {
          hasColorOrSpecs = true;
        }
      }

      if (hasSize && hasColorOrSpecs) {
        return true;
      }
    }
    return false;
  }

  // للـ color/specs
  if (attrName.toLowerCase() == 'color' ||
      attrName.toLowerCase().contains('color') ||
      attrName.toLowerCase().contains('specs')) {
    
    String? selectedSize = selectedAttributes['size'];
    
    // إذا مفيش size مختار، كل الألوان متوفرة
    if (selectedSize == null) {
      for (var variation in widget.variations) {
        if (variation.stockStatus != 'instock') continue;
        for (var attr in variation.attributes) {
          if ((attr.name.toLowerCase().contains('color') ||
               attr.name.toLowerCase().contains('specs')) &&
              attr.option == option) {
            return true;
          }
        }
      }
      return false;
    }

    // نتأكد إن اللون متوفر مع الـ size المختار
    for (var variation in widget.variations) {
      if (variation.stockStatus != 'instock') continue;

      bool hasSize = false;
      bool hasColorOrSpecs = false;

      for (var attr in variation.attributes) {
        if (attr.name == 'size' && attr.option == selectedSize) {
          hasSize = true;
        }
        if ((attr.name.toLowerCase().contains('color') ||
             attr.name.toLowerCase().contains('specs')) &&
            attr.option == option) {
          hasColorOrSpecs = true;
        }
      }

      if (hasSize && hasColorOrSpecs) {
        return true;
      }
    }
    return false;
  }

  // للباقي attributes
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCounterSection(),
        SizedBox(height: 20.h),
        _buildAttributesSections(),
        if (_shouldShowImages()) ...[
          SizedBox(height: 20.h),
          _buildImagesSection(),
        ],
      ],
    );
  }

  Widget _buildImagesSection() {
    final uniqueImageVariations = _getUniqueImageVariations();

    if (uniqueImageVariations.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Available Options',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 15.h),
        SizedBox(
          height: 70.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: uniqueImageVariations.length,
            itemBuilder: (context, index) {
              final variation = uniqueImageVariations[index];
              final isSelected = selectedImageUrl == variation.image;

              return GestureDetector(
                onTap: () => _selectImageVariation(variation),
                child: Container(
                  margin: EdgeInsets.only(right: 12.w),
                  child: Stack(
                    children: [
                      Container(
                        width: 60.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? Colors.black
                                : Colors.grey.shade300,
                            width: isSelected ? 3 : 2,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            variation.image!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey.shade200,
                                child: Icon(
                                  Icons.image_not_supported,
                                  color: Colors.grey.shade400,
                                  size: 20.sp,
                                ),
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                color: Colors.grey.shade200,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation(
                                      Colors.grey.shade400,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      if (isSelected)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 20.w,
                            height: 20.h,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 12.sp,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
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

        if (attrName.toLowerCase() == 'color' ||
            attrName.toLowerCase().contains('color') ||
            attrName.toLowerCase().contains('specs') ||
            attrName.toLowerCase().contains('Specs')) {
          // return _buildAttributeSection(attrName, options, isColor: true);
          return const SizedBox.shrink();
        }

        return _buildAttributeSection(attrName, options);
      }).toList(),
    );
  }

  Color? getColorFromNameOrHex(String colorName) {
    Color? detectedColor = ColorDetectionService.getColorFromText(colorName);

    if (detectedColor != null) {
      return detectedColor;
    }

    final lower = colorName.toLowerCase().trim();
    if (lower.startsWith('#') && (lower.length == 7 || lower.length == 9)) {
      try {
        return Color(int.parse(lower.substring(1), radix: 16) + 0xFF000000);
      } catch (_) {}
    }

    return ColorDetectionService.getDefaultColorByIndex(
      colorName.hashCode.abs(),
    );
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

            final color = isColor ? getColorFromNameOrHex(option) : null;

            return GestureDetector(
              onTap: isAvailable
                  ? () => _updateSelection(attrName, option)
                  : null,
              child: Opacity(
                opacity: isAvailable ? 1.0 : 0.5,
                child: color != null
                    ? buildColorBox(color, isSelected, option)
                    : buildTextBox(option, isSelected, isAvailable),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

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
              color: Colors.black54,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: isSelected
              ? Icon(Icons.check, color: _getContrastColor(color), size: 20.sp)
              : null,
        ),
      ],
    );
  }

  Color _getContrastColor(Color color) {
    double brightness =
        (color.red * 299 + color.green * 587 + color.blue * 114) / 1000;
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
          color: isSelected
              ? Colors.white
              : (isAvailable ? Colors.black : Colors.grey),
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
