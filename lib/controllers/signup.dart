import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:joby/consts/colors.dart';

import '../auth_ui/signinscreen.dart';
import '../model/user.dart';

class SignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var isPasswordVisible = false.obs;

  Future<UserCredential?> signUp(
      String userName,
      String userEmail,
      String userPassword,
      ) async {
    try {
      EasyLoading.show(status: "انتظر قليلاً");

      // إنشاء المستخدم باستخدام Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );

      // إرسال رسالة تحقق عبر البريد الإلكتروني
      await userCredential.user!.sendEmailVerification();

      // إضافة بيانات المستخدم الأساسية فقط إلى Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uId': userCredential.user!.uid,
        'username': userName,
        'email': userEmail,
        'userImg': "",
        'phone': "",
        'city': "",
        'nationality': "",
        'birthDate': "",
        'specialization': "",
        'experienceLevel': "",
        'currentWorkplace': "",
        'skills': [],
        'certificates': [],
        'resume': "",
      });

      EasyLoading.dismiss();

      Get.snackbar(
        "تم إنشاء الحساب بنجاح",
        "تحقق من بريدك الإلكتروني لتأكيد التسجيل",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: appColor,
        colorText: lightGrey,
      );

      Get.offAll(() => const SignInScreen());
      return userCredential;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      String errorMessage;

      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = "البريد الإلكتروني مستخدم بالفعل.";
          break;
        case 'invalid-email':
          errorMessage = "البريد الإلكتروني غير صالح.";
          break;
        case 'weak-password':
          errorMessage = "كلمة المرور ضعيفة جداً.";
          break;
        default:
          errorMessage = "حدث خطأ غير متوقع. حاول مرة أخرى.";
      }

      Get.snackbar(
        "خطأ",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: appColor,
        colorText: lightGrey,
      );
    }
    return null;
  }
}
