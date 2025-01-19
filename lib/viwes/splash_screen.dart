import 'package:flutter/material.dart';
import 'package:joby/consts/colors.dart';
import 'package:joby/consts/consts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
          child:Center(
            child: Column(
              children: [
                const Spacer(),
                Image.asset(icSplash,
                width: 140,),
                const Spacer(),
                const Text(credits,style: TextStyle(),),
                20.heightBox,
              ],
            ),
          ) ),
    );
  }
}
