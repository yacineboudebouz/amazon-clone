import 'package:amazon_clone/core/constants/global_variables.dart';
import 'package:amazon_clone/features/home/view/home_screen.dart';
import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

List<Widget> pages = [
  HomeScreen(),
  Center(
    child: Text('Cart Page'),
  ),
  Center(
    child: Text('Person Page'),
  )
];

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomLineIndicatorBottomNavbar(
          enableLineIndicator: true,
          lineIndicatorWidth: 5,
          indicatorType: IndicatorType.Top,
          selectedColor: GlobalVariables.selectedNavBarColor,
          unSelectedColor: GlobalVariables.unselectedNavBarColor,
          backgroundColor: GlobalVariables.backgroundColor,
          selectedIconSize: 30,
          unselectedIconSize: 30,
          currentIndex: _page,
          // gradient: LinearGradient(
          //   colors: kGradients,
          // ),
          customBottomBarItems: [
            CustomBottomBarItems(
              label: '',
              icon: _page == 0 ? Icons.home : Icons.home_outlined,
            ),
            CustomBottomBarItems(
              label: '',
              icon: _page == 1
                  ? Icons.shopping_cart
                  : Icons.shopping_cart_outlined,
            ),
            CustomBottomBarItems(
              label: '',
              icon: _page == 2 ? Icons.person : Icons.person_outline,
            ),
          ],
          onTap: (val) {
            setState(() {
              _page = val;
            });
          }),
      body: PageView(
        children: [pages[_page]],
        controller: PageController(initialPage: _page),
        onPageChanged: (value) {
          setState(() {
            _page = value;
          });
        },
      ),
    );
  }
}
