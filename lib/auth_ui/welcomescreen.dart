import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joby/auth_ui/signinscreen.dart';
import 'package:joby/auth_ui/signupscreen.dart';
import 'package:joby/consts/colors.dart';

import '../../controllers/googlesignin.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // final GoogleSignInController _googleSignInController = Get.put(GoogleSignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:const IconThemeData(color:whiteColor),
        backgroundColor:appColor,
        title: const Text(
          "!مرحبا بك",
          style: TextStyle(fontSize: 22, color:lightGrey, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          ClipPath(
            clipper:SShapeClipper(), // تطبيق شكل S
            child: Container(
              width: Get.width,
              height: Get.height / 3.5,
              color:appColor,
            ),
          ),
          SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: Get.width,
                    decoration: const BoxDecoration(
                    ),
                    child: const Icon(
                      Icons.laptop,
                      color: Colors.white,
                      size: 200,
                    ),
                  ),
                  SizedBox(height: Get.height / 25),
                  const Text(
                    "استمتع بجولتك",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Get.height / 12),
                  Material(
                    child: Container(
                      decoration: BoxDecoration(
                        color:appColor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      width: Get.width / 1.2,
                      height: Get.height / 12,
                      child: TextButton.icon(
                        onPressed: () {
                          // _googleSignInController.signInWithGoogle();
                        },
                        icon: Image.asset(
                          "assets/images/google_logo.png",
                          width: Get.width / 16,
                          height: Get.height / 16,
                        ),
                        label: const Text(
                          "تسجيل دخول بإستخدام google",
                          style: TextStyle(color:lightGrey),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height / 50),
                  Material(
                    child: Container(
                      decoration: BoxDecoration(
                        color:appColor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      width: Get.width / 1.2,
                      height: Get.height / 12,
                      child: TextButton.icon(
                        onPressed: () {
                          Get.to(() => const SignInScreen());
                        },
                        icon: const Icon(
                          Icons.email,
                          color:lightGrey,
                        ),
                        label: const Text(
                          "تسجيل دخول بإستخدام البريد الإلكتروني",
                          style: TextStyle(color:lightGrey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
