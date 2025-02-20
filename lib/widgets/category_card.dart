import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final Color? color;
  final Color? textColor;
  const CategoryCard({super.key, required this.title, this.color, this.textColor});

  @override
  Widget build(BuildContext context) {
    return   Container(
      padding: const EdgeInsets.fromLTRB(12,8,12,8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: Text(title,style: TextStyle(color:textColor),),
    )
    ;
  }
}
