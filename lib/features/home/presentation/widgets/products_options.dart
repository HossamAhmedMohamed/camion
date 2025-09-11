import 'package:camion/config/widgets/custom_cached_network_image.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/home/data/models/all_products_model/sub_models/product_variations.dart';
import 'package:camion/features/home/presentation/widgets/color_helper.dart';
import 'package:camion/generated/l10n.dart';
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
  String? selectedImageUrl; // للصورة المختارة يدوياً
  ProductVariations? selectedImageVariation;

  @override
  void initState() {
    super.initState();
  }

  void _updateSelection(String attrName, String option) {
    setState(() {
      selectedAttributes[attrName] = option;
    });

    // البحث عن الـ variation المطابق بناءً على الـ attributes المختارة فقط
    final matchingVariation = _findMatchingVariation();
    if (matchingVariation != null) {
      setState(() {
        selectedVariation = matchingVariation;
      });
    }

    _notifyParent();
  }

  void _selectImageVariation(ProductVariations variation) {
    setState(() {
      selectedImageUrl = variation.image;
      selectedImageVariation = variation;

      // تحديث selectedAttributes بناءً على الـ variation المختار من الصورة
      // نستثني الـ size من التحديث
      Map<String, String> newAttributes = {};
      for (var attr in variation.attributes) {
        if (attr.name.toLowerCase() != 'size') {
          newAttributes[attr.name] = attr.option;
        }
      }
      selectedAttributes = {...selectedAttributes, ...newAttributes};
    });

    _notifyParent();
  }

  // إضافة هذه الدالة في أعلى الـ class
  List<String> _sortSizes(List<String> sizes) {
    // قائمة الأحجام المرتبة حسب الأولوية
    final sizeOrder = [
      'XS',
      'S',
      'M',
      'L',
      'XL',
      'XXL',
      'XXXL',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      '11',
      '12',
      '13',
      '14',
      '15',
      '16',
      '17',
      '18',
      '19',
      '20',
      '21',
      '22',
      '23',
      '24',
      '25',
      '26',
      '27',
      '28',
      '29',
      '30',
      '31',
      '32',
      '33',
      '34',
      '35',
      '36',
      '37',
      '38',
      '39',
      '40',
      '41',
      '42',
      '43',
      '44',
      '45',
      '46',
      '47',
      '48',
      '49',
      '50',
      '51',
      '52',
      '53',
      '54',
      '55',
      '56',
      '57',
      '58',
      '59',
      '60',
      '61',
      '62',
      '63',
      '64',
      '65',
      '66',
      '67',
      '68',
      '69',
      '70',
      '71',
      '72',
      '73',
      '74',
      '75',
      '76',
      '77',
      '78',
      '79',
      '80',
      '81',
      '82',
      '83',
      '84',
      '85',
      '86',
      '87',
      '88',
      '89',
      '90',
      '91',
      '92',
      '93',
      '94',
      '95',
      '96',
      '97',
      '98',
      '99',
      '100',
    ];

    // فصل الأحجام الرقمية والحرفية
    List<String> numericSizes = [];
    List<String> textSizes = [];
    List<String> otherSizes = [];

    for (String size in sizes) {
      String cleanSize = size.trim();

      // التحقق إذا كان الحجم رقمي
      if (RegExp(r'^\d+(\.\d+)?$').hasMatch(cleanSize)) {
        numericSizes.add(cleanSize);
      }
      // التحقق إذا كان من الأحجام النصية المعروفة
      else if (sizeOrder.contains(cleanSize.toUpperCase())) {
        textSizes.add(cleanSize);
      }
      // أي أحجام أخرى
      else {
        otherSizes.add(cleanSize);
      }
    }

    // ترتيب الأحجام الرقمية حسب القيمة الرقمية
    numericSizes.sort((a, b) => double.parse(a).compareTo(double.parse(b)));

    // ترتيب الأحجام النصية حسب الترتيب المحدد مسبقاً
    textSizes.sort((a, b) {
      int indexA = sizeOrder.indexOf(a.toUpperCase());
      int indexB = sizeOrder.indexOf(b.toUpperCase());
      return indexA.compareTo(indexB);
    });

    // دمج القوائم: الأحجام النصية أولاً ثم الرقمية ثم الأخرى
    return [...textSizes, ...numericSizes, ...otherSizes];
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
    // إذا كان هناك صورة مختارة يدوياً، نرسل الـ variation الخاص بها
    // وإلا نرسل الـ variation المطابق للـ attributes المختارة
    ProductVariations? variationToSend =
        selectedImageVariation ?? selectedVariation;

    widget.onSelectionChanged?.call(
      selectedAttributes,
      counter,
      variationToSend,
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
        // البحث عن أي attribute عدا الـ size
        String? nonSizeAttribute;
        for (var attr in variation.attributes) {
          if (attr.name.toLowerCase() != 'size') {
            nonSizeAttribute = attr.option;
            break; // نأخذ أول attribute نجده عدا الـ size
          }
        }

        // إذا لم نجد أي attribute عدا الـ size، نستخدم رابط الصورة كـ key
        // أو نستخدم معرف فريد للـ variation
        String key = nonSizeAttribute ?? variation.image!;

        // إذا لم نرَ هذا الـ attribute من قبل، نضيفه
        if (!uniqueVariations.containsKey(key)) {
          uniqueVariations[key] = variation;
        }
      }
    }

    return uniqueVariations.values.toList();
  }

  bool _shouldShowImages() {
    // نتحقق من وجود variations مع صور متاحة
    final hasVariationsWithImages = widget.variations.any(
      (variation) =>
          variation.stockStatus == 'instock' &&
          variation.image != null &&
          variation.image!.isNotEmpty,
    );

    return hasVariationsWithImages;
  }

  bool _isOptionAvailable(String attrName, String option) {
    // للـ size، نتأكد إنه متوفر مع اللون/specs المختار حالياً
    if (attrName.toLowerCase() == 'size') {
      String? selectedColorOrSpecs;

      // أولاً نجرب نجيب اللون من الـ selectedAttributes
      for (var key in selectedAttributes.keys) {
        if (key.toLowerCase().contains('color') ||
            key.toLowerCase().contains('specs')) {
          selectedColorOrSpecs = selectedAttributes[key];
          break;
        }
      }

      // إذا مفيش لون في الـ selectedAttributes، نجربه من الصورة المختارة
      if (selectedColorOrSpecs == null && selectedImageVariation != null) {
        for (var attr in selectedImageVariation!.attributes) {
          if (attr.name.toLowerCase().contains('color') ||
              attr.name.toLowerCase().contains('specs')) {
            selectedColorOrSpecs = attr.option;
            break;
          }
        }
      }

      // إذا مفيش لون مختار خالص، كل الـ sizes متوفرة
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
           S.of(context).available_options,
          style: AppStyle.styleBold18(context),
        ),
        SizedBox(height: 15.h),
        SizedBox(
          height: 70.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: uniqueImageVariations.length,
            itemBuilder: (context, index) {
              final variation = uniqueImageVariations[index];
              // التحقق من التحديد بناءً على الصورة المختارة يدوياً فقط
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
                          child: CustomCachedNetworkImage(
                            imageUrl:  variation.image!,
                            fit: BoxFit.cover,
                           
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
  // ترتيب الـ options إذا كانت sizes
  List<String> sortedOptions = options;
  if (attrName.toLowerCase() == 'size') {
    sortedOptions = _sortSizes(options);
  }

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
        runSpacing: 8.h,
        children: sortedOptions.map((option) {
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
           S.of(context).quantity,
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
