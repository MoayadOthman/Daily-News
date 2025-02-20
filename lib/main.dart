import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Use this for GetMaterialApp
import 'package:joby/auth_ui/signupscreen.dart';
import 'package:joby/auth_ui/splashscreen.dart';
import 'package:joby/consts/consts.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      title: appname,
      theme: ThemeData(
        iconTheme: const IconThemeData(
          color: appColor
        )
      ),
      debugShowCheckedModeBanner: false,
      home:const SplashScreen(),
    );
  }
}
