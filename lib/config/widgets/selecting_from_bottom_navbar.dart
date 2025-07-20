import 'package:camion/features/home/presentation/screens/box_screen.dart';
import 'package:camion/features/home/presentation/screens/home_screen.dart';
import 'package:camion/features/home/presentation/screens/profile_screen.dart';
import 'package:camion/features/home/presentation/screens/search_screen.dart';
import 'package:camion/features/home/presentation/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class SelectingFromBottomNavBar extends StatefulWidget {
  const SelectingFromBottomNavBar({super.key});

  @override
  State<SelectingFromBottomNavBar> createState() =>
      _SelectingFromBottomNavBarState();
}

class _SelectingFromBottomNavBarState extends State<SelectingFromBottomNavBar> {
  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  List<Widget> screens = const [
    HomeScreen(),
    SearchScreen(),
    // ReelsScreen(),
    BoxScreen(),
    ProfileScreen(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool _handleBackPressed() {
    if (currentIndex != 0) {
      _pageController.jumpToPage(0);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: currentIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _handleBackPressed();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              children: screens,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomBottomNavBar(
                currentIndex: currentIndex,
                onTap: (index) {
                  _pageController.jumpToPage(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
