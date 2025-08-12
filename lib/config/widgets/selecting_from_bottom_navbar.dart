 
import 'package:camion/features/order_status/presentation/screens/order_status_screen.dart';
import 'package:camion/features/home/presentation/screens/home_screen.dart';
import 'package:camion/config/widgets/bottom_nav_bar.dart';
import 'package:camion/features/profile/presentation/screens/profile_screen.dart';
import 'package:camion/features/wish_list/presentation/screens/wish_list_screen.dart';
import 'package:flutter/material.dart';

class SelectingFromBottomNavBar extends StatefulWidget {
  const SelectingFromBottomNavBar({super.key});

  @override
  State<SelectingFromBottomNavBar> createState() =>
      _SelectingFromBottomNavBarState();
}

class _SelectingFromBottomNavBarState extends State<SelectingFromBottomNavBar> {
  int currentIndex = 1;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex);
  }

  List<Widget> screens = const [
    
    OrderStatusScreen(),
    HomeScreen(),
    WishListScreen(),
    ProfileScreen()
    // ReelsScreen(),
    // MyCartScreen(),
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
                  if (index == 1) {
                    HomeScreen.homeKey.currentState?.refreshWishList();
                  }
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
