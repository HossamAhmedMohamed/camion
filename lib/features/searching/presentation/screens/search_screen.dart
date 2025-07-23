
import 'package:camion/features/home/presentation/widgets/home_sliver_appbar.dart';
import 'package:camion/features/home/presentation/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [HomeSliverAppBar(), SearchBarHome()],
    );
  }
}
