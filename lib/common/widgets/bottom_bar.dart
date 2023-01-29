import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/auth/screens/account/screens/account_screen.dart';
import 'package:amazon_clone/home/screens/home_screen.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  static const routeName = '/actual-home';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const Center(
      child: Text('Cart Page'),
    ),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 20,
        onTap: updatePage,
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              child: Icon(Icons.home_outlined),
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: bottomBarBorderWidth,
                    color: _page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                  ),
                ),
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              child: Icon(Icons.person_outline_outlined),
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: bottomBarBorderWidth,
                    color: _page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                  ),
                ),
              ),
            ),
          ),
          //cart
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: bottomBarBorderWidth,
                    color: _page == 2
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                  ),
                ),
              ),
              child: Badge(
                badgeContent: const Text('2'),
                badgeStyle: BadgeStyle(
                  badgeColor: Colors.white,
                  elevation: 0,
                ),
                child: Icon(
                  Icons.shopping_cart_outlined,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
