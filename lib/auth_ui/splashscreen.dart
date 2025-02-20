// استيراد مكتبة Timer لتحديد مدة الانتظار قبل الانتقال للشاشة التالية
import 'dart:async';
// استيراد FirebaseAuth للتحقق من حالة تسجيل الدخول
import 'package:firebase_auth/firebase_auth.dart';
// استيراد مكتبة Flutter الأساسية لواجهة المستخدم
import 'package:flutter/material.dart';
// استيراد مكتبة GetX للتحكم في الحالة والتوجيهات
import 'package:get/get.dart';
import 'package:joby/consts/colors.dart';
import 'package:joby/consts/consts.dart';
import 'package:joby/auth_ui/onborading_screen.dart';

import '../viwes/home/BottomNav.dart';




//تعريف و تحديد نوع StatefulWidget   للحفاظ على حالتها أثناء التحميل
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // إنشاء حالة
  State<SplashScreen> createState() => _SplashScreenState();
}

// محتوى الحالة الذي تم انشائها
class _SplashScreenState extends State<SplashScreen> {




  // تنفيذ العملية عند بداية تشغيل الشاشة
  @override
  void initState() {
   super.initState();
  // استخدام Timer للانتظار 3 ثوانٍ قبل الانتقال للشاشة التالية
     Timer(const Duration(seconds: 3), () {
       logged(context);
     });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:appColor, // تحديد لون الخلفية من الثوابت
      body: Container(
        alignment: Alignment.center,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Icon(
              Icons.newspaper_sharp,
              size: 250,
              color: Colors.white, // لون الأيقونة باللون الأبيض
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20.0), // تحديد الهامش السفلي
              alignment: Alignment.center,
              width: Get.width,
              child: const Text(
                appname, // النص من الثوابت
                style: TextStyle(
                  color: Colors.white, // لون النص
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            const Column(
              children: [
                Text(
                  appversion, // النص من الثوابت
                  style: TextStyle(
                    color: Colors.white, // لون النص
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  credits, // النص من الثوابت
                  style: TextStyle(
                    color: Colors.white, // لون النص
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),


              ],
            ),

          ],
        ),
      ),
    );
    ;
  }

  // الحصول على المستخدم الحالي من FirebaseAuth
  User? user = FirebaseAuth.instance.currentUser;
  // دالة لتحديد الشاشة التالية بناءً على حالة تسجيل الدخول وصلاحية المستخدم
  Future<void> logged(BuildContext context) async {
    // التحقق إذا كان المستخدم مسجلاً الدخول
    if (user != null) {
        Get.offAll(() => BottomNav());
      }else{
      // إذا لم يكن المستخدم مسجلاً الدخول، الانتقال إلى شاشة الترحيب
      Get.offAll(() => const OnboardingScreen());
    }
    }


  }
