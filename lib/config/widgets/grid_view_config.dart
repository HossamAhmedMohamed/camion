class AppBreakpoints {
  static const double mobile = 480;
  static const double tablet = 768;
  static const double desktop = 1024;
  static const double largeDesktop = 1440;
}

class GridConfig {
  final int crossAxisCount;
  final double mainAxisExtent;
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  const GridConfig({
    required this.crossAxisCount,
    required this.mainAxisExtent,
    this.crossAxisSpacing = 16,
    this.mainAxisSpacing = 16,
  });

  factory GridConfig.fromWidth(double width) {
    if (width >= AppBreakpoints.largeDesktop) {
      return const GridConfig(crossAxisCount: 5, mainAxisExtent: 420);
    } else if (width >= AppBreakpoints.desktop) {
      return const GridConfig(crossAxisCount: 4, mainAxisExtent: 380);
    } else if (width >= AppBreakpoints.tablet) {
      return const GridConfig(crossAxisCount: 3, mainAxisExtent: 340);
    } else if (width >= AppBreakpoints.mobile) {
      return const GridConfig(crossAxisCount: 2, mainAxisExtent: 320);
    } else {
      return const GridConfig(crossAxisCount: 1, mainAxisExtent: 300);
    }
  }
}