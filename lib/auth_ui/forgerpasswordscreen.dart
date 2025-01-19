import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:joby/auth_ui/signupscreen.dart';
import 'package:joby/consts/colors.dart';

import '../controllers/forgetpassword.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final ForgetPasswordController _forgetPasswordController = Get.put(ForgetPasswordController());
  final TextEditingController userEmail = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    userEmail.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: appColor,
            title: const Text(
              "نسيت كلمة السر؟",
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
              ClipPath(
                clipper: SShapeClipper(),
                child: Container(
                  width: Get.width,
                  height: Get.height / 3.5,
                  color: appColor,
                ),
              ),
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                       const Icon(
                         Icons.laptop,
                          color: Colors.white,
                          size: 200,
                        ),

                      SizedBox(height: Get.height / 50),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: TextFormField(
                          controller: userEmail,
                          cursorColor: appColor,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)
                              ),
                            ),
                            focusedBorder:OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(30)
                                )
                            ) ,
                            errorBorder:OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(30)
                                )
                            ) ,

                            hintText: "البريد الإلكتروني",
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height / 50),
                      SizedBox(height: Get.height / 25),
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
                              String email=userEmail.text.trim();
                              if(email.isEmpty){
                                Get.snackbar(
                                  "خطأ",
                                  "ادخل بريدك الإلكتروني لإعادة تعيين كلمة سر",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor:appColor,
                                  colorText:lightGrey,
                                );
                              }else{
                               await _forgetPasswordController.forgetPassword(email);
                              }
                            },
                            child: const Text(
                              "إرسال",
                              style: TextStyle(
                                color: appColor,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height / 30),
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
