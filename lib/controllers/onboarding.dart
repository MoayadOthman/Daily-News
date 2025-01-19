import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class OnboardingController extends GetxController {
  PageController pageController = PageController(); // التهيئة الصحيحة

  final _currentIndex = 0.obs;
  get currentIndex => _currentIndex.value;
  set currentIndex(value) => _currentIndex.value = value;

  changeIndex(int value) {
    currentIndex = value;
  }

  changePage(int value) {
    pageController.animateToPage(
      value,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  @override
  void onClose() {
    pageController.dispose(); // تحرير الموارد
    super.onClose();
  }
}
