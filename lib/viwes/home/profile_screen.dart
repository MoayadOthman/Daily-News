import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:joby/auth_ui/onborading_screen.dart';
import 'package:joby/consts/consts.dart';
import 'package:joby/widgets/profile_button.dart';

import '../bookmark_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile',style: TextStyle(color: appColor,fontSize: 30,fontWeight: FontWeight.bold),),
      ),
      body:Padding(
          padding:const EdgeInsets.all(12),
      child: Column(
        children: [
          ProfileButton(
            title: 'Login',
            color: Colors.blue,
            icon: Icons.person,
            press: (){},
            isSwitch: false,
          ),
          10.heightBox,
          const Text('General Settings',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: titleProfile.length,
              itemBuilder: (context, index) {
                  return ProfileButton(
                    press: (){
                      switch(index){
                        case 0:
                          Get.to(()=>const BookmarkScreen());
                          break;
                      }
                    },
                    isSwitch:index==1||index==2?true:false,
                      title:titleProfile[index],
                      color:titleColor[index],
                      icon:titleIcon[index]);
                },),
          )

        ],
      ),
      ),
    );
  }
}
