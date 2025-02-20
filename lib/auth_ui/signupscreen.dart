import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joby/consts/colors.dart';

import '../controllers/signup.dart';
import '../widgets/custom_text_form.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController _signUpController = Get.put(SignUpController());
  final TextEditingController username = TextEditingController();
  final TextEditingController userEmail = TextEditingController();
  final TextEditingController userPassword = TextEditingController();

  @override
  void dispose() {
    username.dispose();
    userEmail.dispose();
    userPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: const Text(
          "إنشاء حساب",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomTextForm(controller: username, title: "اسم المستخدم", icon:Icons.person_3,validator:(valid){} ,type: TextInputType.name,),
              const SizedBox(height: 16),
              CustomTextForm(controller: userEmail, title: 'البريد الإلكتروني', icon:Icons.email_outlined,validator:(valid){} ,type: TextInputType.emailAddress,),
              const SizedBox(height: 16),
              Obx(() => TextFormField(
                controller: userPassword,
                obscureText: !_signUpController.isPasswordVisible.value,
                decoration: InputDecoration(
                  hintText: "كلمة المرور",
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: _signUpController.isPasswordVisible.value
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                    onPressed: () {
                      _signUpController.isPasswordVisible.toggle();
                    },
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                ),
              )),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () async {
                  String name = username.text.trim();
                  String email = userEmail.text.trim();
                  String password = userPassword.text.trim();

                  if (name.isEmpty || email.isEmpty || password.isEmpty) {
                    Get.snackbar(
                      "خطأ",
                      "يرجى إدخال جميع الحقول",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: appColor,
                      colorText: lightGrey,
                    );
                  } else {
                    await _signUpController.signUp(name, email, password);
                  }
                },
                child: const Text(
                  "إنشاء حساب",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);

    path.quadraticBezierTo(
      size.width * 0.25, size.height,
      size.width * 0.5, size.height - 50,
    );

    path.quadraticBezierTo(
      size.width * 0.75, size.height - 100,
      size.width, size.height - 50,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

