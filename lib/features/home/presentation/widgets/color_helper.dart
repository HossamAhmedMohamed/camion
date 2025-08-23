import 'package:flutter/material.dart';

class ColorDetectionService {
  // 1. قاموس شامل للألوان المحتملة
  static const Map<String, Color> extendedColorMap = {
    // الألوان الأساسية
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
    "brown": Color(0xFF8B4513),
    
    // ألوان الطبيعة والنباتات
    "hibiscus": Color(0xFFDC143C), // Deep red
    "rose": Color(0xFFFF69B4),
    "lavender": Color(0xFFE6E6FA),
    "mint": Color(0xFF98FB98),
    "sage": Color(0xFF9CAF88),
    "olive": Color(0xFF808000),
    "forest": Color(0xFF228B22),
    "jungle": Color(0xFF29AB87),
    "fairy": Color(0xFF90EE90),
    "emerald": Color(0xFF50C878),
    "jade": Color(0xFF00A86B),
    
    // ألوان الخشب والمكسرات
    "chestnut": Color(0xFF954535),
    "walnut": Color(0xFF8B4513),
    "mahogany": Color(0xFFC04000),
    "oak": Color(0xFFD2B48C),
    "cedar": Color(0xFF8B4513),
    "pine": Color(0xFF01796F),
    "bamboo": Color(0xFFC7B377),
    
    // ألوان الطعام والتوابل
    "cinnamon": Color(0xFFD2691E),
    "vanilla": Color(0xFFF3E5AB),
    "chocolate": Color(0xFFD2691E),
    "coffee": Color(0xFF6F4E37),
    "caramel": Color(0xFFAF6E4D),
    "honey": Color(0xFFFFC30B),
    "cream": Color(0xFFFFFDD0),
    "butter": Color(0xFFEDDC05),
    "lemon": Color(0xFFFFF700),
    "lime": Color(0xFF32CD32),
    "berry": Color(0xFF8B0045),
    "cherry": Color(0xFFDE3163),
    "grape": Color(0xFF6F2DA8),
    "peach": Color(0xFFFFDAB9),
    "apricot": Color(0xFFFF8C69),
    
    // ألوان المعادن والأحجار
    "gold": Color(0xFFFFD700),
    "silver": Color(0xFFC0C0C0),
    "copper": Color(0xFFB87333),
    "bronze": Color(0xFFCD7F32),
    "platinum": Color(0xFFE5E4E2),
    "pearl": Color(0xFFF0EAD6),
    "diamond": Color(0xFFB9F2FF),
    "ruby": Color(0xFFE0115F),
    "sapphire": Color(0xFF0F52BA),
    "amethyst": Color(0xFF9966CC),
    "topaz": Color(0xFFFFC87C),
    
    // ألوان البحر والسماء
    "ocean": Color(0xFF006994),
    "sea": Color(0xFF006994),
    "navy": Color(0xFF000080),
    "sky": Color(0xFF87CEEB),
    "azure": Color(0xFF007FFF),
    "turquoise": Color(0xFF40E0D0),
    "aqua": Color(0xFF00FFFF),
    "teal": Color(0xFF008080),
    "coral": Color(0xFFFF7F50),
    
    // درجات الرمادي
    "charcoal": Color(0xFF36454F),
    "slate": Color(0xFF708090),
    "ash": Color(0xFFB2BEB5),
    "smoke": Color(0xFF738276),
    "steel": Color(0xFF4682B4),
    "pewter": Color(0xFF96A8A1),
    "graphite": Color(0xFF41424C),
    
    // ألوان الباستيل
    "powder": Color(0xFFFFB6C1), // Light pink for "powder"
    "pastel": Color(0xFFFFB6C1),
    "soft": Color(0xFFFFE4E6),
    "light": Color(0xFFF0F0F0),
    "pale": Color(0xFFF5F5F5),
    "muted": Color(0xFFD3D3D3),
    
    // ألوان الأرض
    "earth": Color(0xFF964B00),
    "sand": Color(0xFFC2B280),
    "clay": Color(0xFFA0522D),
    "mud": Color(0xFF70543E),
    "dust": Color(0xFFD2B48C),
    "stone": Color(0xFF928E85),
    "rock": Color(0xFF71797E),
    "Cocoa" : Color(0xFFD2691E),
  };

  // 2. قاموس للكلمات المركبة والعبارات الشائعة
  static const Map<String, Color> compoundColorMap = {
    "hibiscus powder": Color(0xFFDC143C), // Deep red with powder effect
    "fairy green": Color(0xFF90EE90), // Light fairy green
    "forest green": Color(0xFF228B22),
    "sea blue": Color(0xFF006994),
    "sky blue": Color(0xFF87CEEB),
    "rose gold": Color(0xFFE8B4B8),
    "champagne gold": Color(0xFFF7E7CE),
    "antique white": Color(0xFFFAEBD7),
    "off white": Color(0xFFFDF6E3),
    "deep blue": Color(0xFF00008B),
    "light blue": Color(0xFFADD8E6),
    "light yellow": Color(0xFFFFFACD),
    "dark green": Color(0xFF006400),
    "light green": Color(0xFF90EE90),
    "bright red": Color(0xFFFF0000),
    "dark red": Color(0xFF8B0000),
    "wine red": Color(0xFF722F37),
    "burgundy red": Color(0xFF800020),
    "Cocoa" : Color(0xFFD2691E),
  };

  // 3. الدالة الرئيسية لاستخراج اللون
  static Color? getColorFromText(String colorText) {
    if (colorText.isEmpty) return null;
    
    final normalized = colorText.toLowerCase().trim();
    
    // البحث المباشر في قاموس الألوان المركبة أولاً
    if (compoundColorMap.containsKey(normalized)) {
      return compoundColorMap[normalized];
    }
    
    // البحث في قاموس الألوان الشامل
    if (extendedColorMap.containsKey(normalized)) {
      return extendedColorMap[normalized];
    }
    
    // تحليل النص وتقسيمه
    return _analyzeColorText(normalized);
  }

  // 4. تحليل متقدم للنصوص المعقدة
  static Color? _analyzeColorText(String text) {
    // تنظيف النص من الرموز
    String cleanText = text.replaceAll(RegExp(r'[^\w\s]'), ' ');
    List<String> words = cleanText.split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .toList();
    
    // البحث عن أي كلمة في القواميس
    for (String word in words) {
      // البحث المباشر
      if (extendedColorMap.containsKey(word)) {
        return extendedColorMap[word];
      }
      
      // البحث الجزئي
      for (String colorKey in extendedColorMap.keys) {
        if (word.contains(colorKey) || colorKey.contains(word)) {
          return extendedColorMap[colorKey];
        }
      }
    }
    
    // تحليل سياقي متقدم
    return _contextualAnalysis(text, words);
  }

  // 5. التحليل السياقي
  static Color? _contextualAnalysis(String fullText, List<String> words) {
    // إذا كان النص يحتوي على "powder" مع أي لون
    if (fullText.contains('powder')) {
      for (String word in words) {
        if (word != 'powder' && extendedColorMap.containsKey(word)) {
          // إرجاع نسخة فاتحة من اللون
          Color? baseColor = extendedColorMap[word];
          if (baseColor != null) {
            return Color.lerp(baseColor, Colors.white, 0.3); // مزج مع الأبيض
          }
        }
      }
      return const Color(0xFFFFB6C1); // وردي فاتح افتراضي للبودرة
    }
    
    // إذا كان النص يحتوي على "fairy" أو "light" أو "soft"
    if (fullText.contains('fairy') || fullText.contains('light') || fullText.contains('soft')) {
      for (String word in words) {
        if (extendedColorMap.containsKey(word)) {
          Color? baseColor = extendedColorMap[word];
          if (baseColor != null) {
            return Color.lerp(baseColor, Colors.white, 0.4); // نسخة أفتح
          }
        }
      }
    }
    
    // إذا كان النص يحتوي على "dark" أو "deep"
    if (fullText.contains('dark') || fullText.contains('deep')) {
      for (String word in words) {
        if (extendedColorMap.containsKey(word)) {
          Color? baseColor = extendedColorMap[word];
          if (baseColor != null) {
            return Color.lerp(baseColor, Colors.black, 0.3); // نسخة أغمق
          }
        }
      }
    }
    
    // محاولة استنتاج من الكلمات الشائعة
    return _inferFromCommonWords(words);
  }

  // 6. الاستنتاج من الكلمات الشائعة
  static Color? _inferFromCommonWords(List<String> words) {
    for (String word in words) {
      // كلمات تدل على الأحمر
      if (['hibiscus', 'rose', 'cherry', 'berry', 'wine', 'ruby'].contains(word)) {
        return const Color(0xFFDC143C);
      }
      
      // كلمات تدل على الأخضر
      if (['fairy', 'forest', 'leaf', 'mint', 'sage', 'emerald'].contains(word)) {
        return const Color(0xFF90EE90);
      }
      
      // كلمات تدل على البني
      if (['chestnut', 'walnut', 'wood', 'chocolate', 'coffee ' , "cocoa"].contains(word)) {
        return const Color(0xFF954535);
      }
      
      // كلمات تدل على الأزرق
      if (['ocean', 'sea', 'sky', 'navy', 'azure'].contains(word)) {
        return const Color(0xFF4169E1);
      }
    }
    
    return null;
  }

  // 7. ألوان افتراضية للحالات غير المعروفة
  static List<Color> getDefaultColors() {
    return [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.pink,
      Colors.brown,
      Colors.grey,
      const Color(0xFF8B4513), // Brown
      const Color(0xFF2E8B57), // Sea green
    ];
  }

  // 8. إرجاع لون افتراضي بناءً على الفهرس
  static Color getDefaultColorByIndex(int index) {
    final colors = getDefaultColors();
    return colors[index % colors.length];
  }
}