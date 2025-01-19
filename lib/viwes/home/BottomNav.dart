import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:joby/consts/colors.dart';
import 'package:joby/viwes/home/home_screen.dart';

import '../add_screen.dart';
import '../profile/profile_screen.dart';
import '../search/my_apply_screen.dart';


class BottomNav extends StatefulWidget {
  BottomNav({super.key});
  @override
  State<BottomNav> createState() => _BottomNavState();
  User? user = FirebaseAuth.instance.currentUser;

}

class _BottomNavState extends State<BottomNav> {
  int _bottomNavIndex = 0;

  List<String> titleList = [
    'البحث',
    "الطلبات",
    "الإشعارات",
    "الملف الشخصي",
  ];
  List<IconData> iconList = [
    Icons.home,
    Icons.work,
    Icons.notifications,
    Icons.person,
  ];

  List<Widget> pages = [
    JobSearchPage(),
    AppliedJobsPage(),
    const NotificationScreen(),
    ProfileScreen(),

  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _bottomNavIndex,
        children: pages,
      ),
      bottomNavigationBar:
      AnimatedBottomNavigationBar.builder(
        elevation: 10,
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          return Center( // ضمان أن الأيقونات تكون في المنتصف
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center, // لضبط الأيقونات في المنتصف رأسياً
              children: [
                Icon(
                  iconList[index],
                  color: isActive ? Colors.blue : Colors.black.withOpacity(0.5),
                  size: 30, // حجم الأيقونة
                ),
                const SizedBox(height: 5), // مسافة اختيارية
                if (isActive) ...[
                  Text(
                    titleList[index],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ],
            ),
          );
        },
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.none, // يمكن ضبطها حسب الحاجة
        notchSmoothness: NotchSmoothness.softEdge, // شكل سلس للحواف
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
      ),
    );
  }
}
