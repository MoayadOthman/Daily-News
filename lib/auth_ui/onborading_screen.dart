import 'package:flutter/material.dart'; // استيراد مكتبة واجهات المستخدم الخاصة بـ Flutter
import 'package:get/get.dart'; // استيراد مكتبة GetX لإدارة الحالة والتوجيه
import 'package:joby/auth_ui/welcomescreen.dart';
import 'package:joby/consts/consts.dart'; // استيراد ملف يحتوي على الثوابت المخصصة (مثل الألوان والخطوط)
import 'package:joby/controllers/onboarding.dart'; // استيراد ملف التحكم الخاص بشاشة Onboarding

// تعريف واجهة شاشة Onboarding باستخدام GetView
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key}); // التهيئة باستخدام المفتاح (key) الافتراضي

  @override
  Widget build(BuildContext context) {
    // إنشاء كائن تحكم من OnboardingController باستخدام Get.put
    final OnboardingController _onboardingController = Get.put(OnboardingController());

    return Scaffold(
      body: SafeArea( // يضمن عدم التداخل مع المناطق الآمنة مثل شريط الحالة
        child: PageView.builder( // عنصر واجهة لإنشاء صفحات قابلة للتمرير
          itemCount: 3, // عدد الصفحات
          controller:_onboardingController.pageController,
          onPageChanged: (value) => _onboardingController.changeIndex(value), // استدعاء دالة تغيير الفهرس عند تغيير الصفحة
          itemBuilder: (context, index) { // بناء محتوى كل صفحة
            return Container( // حاوية لكل صفحة
              child: Column( // عرض المحتوى كعناصر عمودية
                children: [
                  Expanded( // توسيع الصورة لتأخذ جزأين من الشاشة
                    flex: 2,
                    child:
                    Image.asset(onboarding[index]), // عرض صورة من الأصل
                  ),
                  Expanded( // توسيع النصوص والأشكال لتأخذ جزءًا واحدًا من الشاشة
                    child: Column(
                      children: [
                        Text(
                          onboardingTitle[index], // نص عنوان
                          style: const TextStyle(fontSize: 18, fontFamily: bold), // تخصيص الخط والحجم
                        ),
                        const SizedBox(height: 6), // مساحة عمودية بين النص والشكل
                        Container( // شريط عرضي ملون
                          height: 5,
                          width: 100,
                          decoration: BoxDecoration(
                            color: appColor, // لون الشريط
                            borderRadius: BorderRadius.circular(5), // زوايا دائرية
                          ),
                        ),
                        const SizedBox(height: 30), // مساحة عمودية أكبر
                         Text(
                          onboardingTitle[index], // نص إضافي
                          style: const TextStyle(fontSize: 16, color: fontGrey, fontFamily: semibold), // تخصيص الخط والحجم
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Row( // شريط التنقل السفلي
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // توزيع العناصر بالتساوي على الأطراف
        children: [
          TextButton( // زر نصي لتخطي الشاشات
            onPressed: () {}, // تنفيذ إجراء عند الضغط
            child:  TextButton(onPressed:(){
              Get.to(()=>const WelcomeScreen());
            } ,
             child:  const Text('تخطي',
               style: TextStyle(fontSize: 16, color: fontGrey, fontFamily: semibold), // تخصيص الخط
             ), // النص المعروض
            ),
          ),
          Obx(() => Row( // ملاحظة تغييرات الفهرس باستخدام Obx
            mainAxisAlignment: MainAxisAlignment.center, // وضع النقاط في المنتصف
            children: List.generate( // إنشاء قائمة من النقاط
              3, // عدد النقاط
                  (index) => Container(
                height: 5, // ارتفاع النقطة
                width: index == _onboardingController.currentIndex ? 20 : 5, // عرض النقطة بناءً على الفهرس الحالي
                margin: const EdgeInsets.symmetric(horizontal: 5), // مسافة أفقية بين النقاط
                decoration: BoxDecoration(
                  color: index == _onboardingController.currentIndex ? appColor : fontGrey, // تغيير اللون بناءً على الفهرس
                  borderRadius: BorderRadius.circular(5), // زوايا دائرية
                ),
              ),
            ),
          )),
          Obx(() => _onboardingController.currentIndex < 2
              ? IconButton(
            onPressed: () {
              print('Navigating to page: ${_onboardingController.currentIndex + 1}');
              _onboardingController.changePage(_onboardingController.currentIndex + 1);
            },
            icon: Container(
              padding: const EdgeInsets.only(left: 12, bottom: 12, top: 12),
              decoration: const BoxDecoration(
                color: appColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_forward_ios, color: whiteColor, size: 35),
            ),
          )
              : TextButton(
            onPressed: () {
              Get.to(() => const WelcomeScreen());
            },
            child: const Text(
              'Continue',
              style: TextStyle(fontSize: 18, fontFamily: semibold, color: appColor),
            ),
          ),
          )

        ],
      ),
    );
  }
}
