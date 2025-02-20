import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:joby/viwes/category_screen.dart';
import 'package:joby/viwes/home/profile_screen.dart';
import 'package:joby/viwes/video_screen.dart';

import '../../consts/colors.dart';
import 'home_screen.dart';

class BottomNav extends StatefulWidget {
  BottomNav({super.key});
  @override
  State<BottomNav> createState() => _BottomNavState();
  User? user = FirebaseAuth.instance.currentUser;

}

class _BottomNavState extends State<BottomNav> {
  int _bottomNavIndex = 0;

  //حالة اردت إضتفة اسم اسفل icons
  // List<String> titleList = [
  //   'Home',
  //   "Favorite",
  //   "Cart",
  //   "Profile",
  // ];
  List<IconData> iconList = [
    Icons.home,
    Icons.video_collection,
    Icons.category,
    Icons.person,
  ];

  List<Widget> pages = [
    const HomeScreen(),
    const VideoScreen(),
    // ProfileScreen(),
    CategoriesPage(),
    const ProfileScreen()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _bottomNavIndex,
        children: pages,
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        elevation: 10,
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (isActive)
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      border: Border.all(
                        color:appColor,
                        width: 2,
                      ),
                    ),
                  ),
                Icon(iconList[index],
                  color: isActive ? appColor : Colors.black.withOpacity(0.5),
                ),
              ],
            ),
          );
        },
        activeIndex: _bottomNavIndex,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
      ),
    );
  }
}
