// استيراد FirebaseAuth للتحقق من المستخدم وتسجيل الدخول
import 'package:firebase_auth/firebase_auth.dart';
// استيراد مكتبة Flutter الأساسية
import 'package:flutter/material.dart';
// استيراد مكتبة KeyboardVisibility لتحديد ما إذا كان لوحة المفاتيح مرئية
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
// استيراد مكتبة GetX للتحكم في الحالة والتوجيهات
import 'package:get/get.dart';
import 'package:joby/auth_ui/signupscreen.dart';
import 'package:joby/consts/colors.dart';
// استيراد وحدات التحكم اللازمة
import '../../controllers/getuserdata.dart';
import '../../controllers/signin.dart';
import '../widgets/custom_text_form.dart';
import 'forgerpasswordscreen.dart';
// استيراد الثوابت المستخدمة في التطبيق
// استيراد الشاشة الرئيسية للمدير

// تعريف واجهة شاشة تسجيل الدخول كـ StatefulWidget للحفاظ على حالتها أثناء الاستخدام
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

// إنشاء الحالة (State) لشاشة تسجيل الدخول
class _SignInScreenState extends State<SignInScreen> {
  // إنشاء كائنات وحدات التحكم وتخزين بياناتها باستخدام Get.put
  final SignInController _signInController = Get.put(SignInController());
  final GetUserDataController _getUserDataController = Get.put(GetUserDataController());

  // متغيرات لتخزين البريد الإلكتروني وكلمة المرور
  final TextEditingController userEmail = TextEditingController();
  final TextEditingController userPassword = TextEditingController();

  // مفتاح للتحقق من صحة نموذج الإدخال
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // تنظيف حقول الإدخال عند إلغاء شاشة تسجيل الدخول
  @override
  void dispose() {
    userEmail.dispose();
    userPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor:appColor,
            iconTheme: const IconThemeData(color: Colors.white),// لون الخلفية من الثوابت
            title: const Text(
              "تسجيل دخول",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              // الشكل العلوي S
              ClipPath(
                clipper: SShapeClipper(),
                child: Container(
                  width: Get.width,
                  height: Get.height / 3.5,
                  color:appColor,
                ),
              ),
              // نموذج الإدخال مع إمكانية التمرير
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // عرض الرسالة العلوية عند إخفاء لوحة المفاتيح
                      isKeyboardVisible
                          ? const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "مرحبا بك!",
                          style: TextStyle(
                            fontSize: 22,
                            color:appColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                          :
                      const Icon(
                        Icons.laptop,
                        color: Colors.white,
                        size: 200,
                      ),
                      SizedBox(height: Get.height / 50),
                      // حقل إدخال البريد الإلكتروني
                      CustomTextForm(controller: userEmail, title: 'البريد الإلكتروني', icon:Icons.email_outlined,validator:(valid){} ,type: TextInputType.emailAddress,),
                      SizedBox(height: Get.height / 50),
                      // حقل إدخال كلمة المرور مع خيار إظهار/إخفاء

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Obx(() => TextFormField(
                          //الوصول الى المتغير و احضار قيمته
                          obscureText: !_signInController.isPasswordVisible.value,
                          controller: userPassword,
                          cursorColor:appColor,
                          //الحالة الطبيعية مرئي
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)
                              ),
                            ),
                            focusedBorder:const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(30)
                                )
                            ) ,
                            errorBorder:const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(30))
                            ),

                            hintText: "كلمة السر",
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: _signInController.isPasswordVisible.value
                              //true
                                  ? const Icon(Icons.visibility)
                              //false
                                  : const Icon(Icons.visibility_off),
                              onPressed: () {
                              //change its state
                                _signInController.isPasswordVisible.toggle();
                              },
                            ),
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'ادخل كلمة السر';
                            }
                            if (value.trim().length < 6) {
                              return 'كلمة السر يجب أن تكون على الأقل 6 أحرف';
                            }
                            return null;
                          },
                        )),
                      ),
                      // رابط لإعادة تعيين كلمة المرور
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Get.to(() => const ForgetPasswordScreen());
                          },
                          child: const Text(
                            "هل نسيت كلمة السر؟",
                            style: TextStyle(
                              fontSize: 20,
                              color: appColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height / 25),
                      // زر تسجيل الدخول
                      Material(
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                            color: appColor,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          width: Get.width / 2,
                          height: Get.height / 18,
                          child: TextButton(
                            onPressed: () async {
                              // استخلاص قيمة البريد الإلكتروني المدخلة في الحقل وتقطيع أي مسافات فارغة حولها
                              String email = userEmail.text.trim();
                              // استخلاص كلمة المرور المدخلة وتقطيع أي مسافات إضافية
                              String password = userPassword.text.trim();
                              if(email.isEmpty||password.isEmpty){
                                Get.snackbar(
                                  "خطأ",
                                  "ادخل جميع الحقول",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: appColor,
                                  colorText:lightGrey,
                                );
                              }else{

                                // محاولة تسجيل الدخول باستخدام البيانات المقدمة (البريد الإلكتروني وكلمة المرور)

                                UserCredential? userCredential = await _signInController.signIn(email, password);

                                //تمرير بعد تسجيل الدخول uid

                                var userData = await _getUserDataController.getUserData(userCredential!.user!.uid);

                                if (userCredential != null) {
                                  // التحقق مما إذا كان البريد الإلكتروني للمستخدم قد تم التحقق منه
                                  if (userCredential.user!.emailVerified) {

                                    // التحقق مما إذا كان المستخدم مسجلاً كمسؤول (Admin)
                                    if (userData[0]['isAdmin'] == true) {
                                      // عرض رسالة نجاح للمسؤول
                                      Get.snackbar(
                                        "تسجيل دخول المسؤول",
                                        "!تم تسجيل الدخول بنجاح",
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: appColor,
                                        colorText:lightGrey,
                                      );
                                      // التوجيه إلى الشاشة الرئيسية للمسؤول (AdminMainScreen)
                                      // Get.offAll(() => const AdminMainScreen());
                                    }
                                    else {
                                      // عرض رسالة نجاح إذا كان المستخدم ليس مسؤولاً
                                      Get.snackbar(
                                        "تسجيل دخول المستخدم",
                                        "!تم تسجيل الدخول بنجاح",
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: appColor,
                                        colorText:lightGrey,
                                      );

                                      // التوجيه إلى واجهة المستخدم العادية (BottomNav)
                                      // Get.offAll(() => BottomNav());
                                    }
                                  } else {
                                    // إذا لم يتم التحقق من البريد الإلكتروني، يعرض رسالة خطأ
                                    Get.snackbar(
                                      "خطأ",
                                      "تحقق من بريدك الإلكتروني قبل تسجيل الدخول",
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: appColor,
                                      colorText:lightGrey,
                                    );
                                  }
                                }

                              }
                            },
                            child: const Text(
                              "تسجيل دخول",
                              style: TextStyle(
                                color: appColor,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height / 30),
                      // رابط لإنشاء حساب جديد
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "  ليس لديك حساب؟",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.offAll(() => const SignUpScreen());
                            },
                            child: const Text(
                              " إنشاء حساب",
                              style: TextStyle(
                                fontSize: 16,
                                color:appColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height / 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}


