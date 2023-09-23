import 'package:amazon_clone/features/admin/view/posts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/global_variables.dart';

class AdminScreen extends ConsumerStatefulWidget {
  const AdminScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdminScreenState();
}

const List<Widget> pages = [
  PostsScreen(),
  Center(
    child: Text('2'),
  ),
  Center(
    child: Text('3'),
  ),
];

class _AdminScreenState extends ConsumerState<AdminScreen> {
  int _page = 0;
  double bottomBarWidth = 42.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/amazon_in.png',
                  width: 120,
                  height: 45,
                  color: Colors.black,
                ),
              ),
              const Text(
                'Admin',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              )
            ],
          ),
        ),
      ),
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
                icon: Icon(
                  Icons.analytics_outlined,
                  color: _page == 1
                      ? GlobalVariables.selectedNavBarColor
                      : GlobalVariables.unselectedNavBarColor,
                  size: 40,
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
                  Icons.all_inbox_outlined,
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
      body: pages[_page],
    );
  }
}
