import 'package:camion/features/home/presentation/widgets/home_sliver_appbar.dart';
import 'package:camion/features/home/presentation/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const HomeSliverAppBar(),
        const SearchBarHome(),
        SliverToBoxAdapter(child: SizedBox(height: 100.h)),
      ],
    );
  }
}
