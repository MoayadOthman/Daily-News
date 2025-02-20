import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';

import '../consts/colors.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({
    super.key,
    required this.controller, required this.title, required this.icon, this.type, this.validator,
  });

  final TextEditingController controller;
  final String title;
  final IconData icon;
  final TextInputType? type;
 final FormFieldValidator<String>? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor:appColor,
      keyboardType:type,
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
        hintText: title,
        prefixIcon:  Icon(icon),
        border: const OutlineInputBorder(

        ),
      ),
      validator:validator,
    );
  }
}
