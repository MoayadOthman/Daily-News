import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../widgets/category_card.dart';
import '../../widgets/news_card.dart';
import 'news_details_screen.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(),
      body:ListView.builder(
        itemBuilder: (context, index) {
          return InkWell(
              onTap: (){
                Get.to(() => const NewsDetailsScreen(article: {},));
              },
              child:  NewsCard(index: index,));
        },),
    );
  }
}
