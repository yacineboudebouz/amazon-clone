import 'package:amazon_clone/core/constants/global_variables.dart';
import 'package:amazon_clone/features/account/view/account_screen.dart';
import 'package:amazon_clone/features/home/view/home_screen.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

const List<Widget> pages = [
  HomeScreen(),
  Center(
    child: Text('Cart Page'),
  ),
  AccountScreen()
];

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: _page == 0
                      ? BorderSide(
                          width: 5, color: GlobalVariables.selectedNavBarColor)
                      : BorderSide.none,
                ),
              ),
              padding: const EdgeInsets.all(15),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _page = 0;
                  });
                },
                icon: Icon(
                  Icons.home_outlined,
                  color: _page == 0
                      ? GlobalVariables.selectedNavBarColor
                      : GlobalVariables.unselectedNavBarColor,
                  size: 40,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: _page == 1
                          ? BorderSide(
                              width: 5,
                              color: GlobalVariables.selectedNavBarColor)
                          : BorderSide.none)),
              padding: const EdgeInsets.all(15),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _page = 1;
                  });
                },
                icon: Badge(
                  label: const Text('2'),
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    color: _page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.unselectedNavBarColor,
                    size: 40,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: _page == 2
                          ? BorderSide(
                              width: 5,
                              color: GlobalVariables.selectedNavBarColor)
                          : BorderSide.none)),
              padding: const EdgeInsets.all(15),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _page = 2;
                  });
                },
                icon: Icon(
                  Icons.person_outline,
                  color: _page == 2
                      ? GlobalVariables.selectedNavBarColor
                      : GlobalVariables.unselectedNavBarColor,
                  size: 40,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
