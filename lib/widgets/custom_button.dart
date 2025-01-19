import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:joby/consts/consts.dart';

import '../consts/colors.dart';
import '../consts/images.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final String image;
  final Color color;
  final VoidCallback onPress;
  const CustomButton({super.key, required this.title, required this.image, required this.color, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return     Padding(
      padding: const EdgeInsets.only(left: 15.0,right: 15,bottom: 10),
      child: MaterialButton(
        shape: OutlineInputBorder(
          borderSide: BorderSide(width: 0,color: appColor),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        padding: EdgeInsets.symmetric(vertical: 15),
        color:color,
        onPressed: onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image,width: 25,height: 25,),
            15.widthBox,
            Text(title,style: TextStyle(fontSize: 18,color: whiteColor),),
          ],
        ),),
    );
  }
}
