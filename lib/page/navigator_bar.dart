import 'package:flutter/material.dart';
import 'package:rest_api_example/page/food_pages/food_page/food_page.dart';

import 'food_pages/food_home_page.dart';
import 'material_page.dart';

class NavigatorBar extends StatefulWidget {
  const NavigatorBar({super.key});

  @override
  State<NavigatorBar> createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  List<Widget> pages = const [FoodHomePage(), FoodPage(), MatPage()];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            selectedFontSize: 10,
            currentIndex: currentIndex,
            onTap: (int currentPageIndex) {
              setState(() {
                currentIndex = currentPageIndex;
              });
            },
            backgroundColor: Colors.deepPurple.shade200,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white54,
            iconSize: 32,
            items: const [
              BottomNavigationBarItem(
                label: "",
                activeIcon: Icon(
                  Icons.home,
                ),
                icon: Icon(
                  Icons.home,
                ),
              ),
              BottomNavigationBarItem(
                label: "",
                icon: Icon(Icons.search),
              ),
              BottomNavigationBarItem(
                label: "",
                icon: Icon(Icons.settings),
              ),
            ]),
        body: pages[currentIndex]);
  }
}
