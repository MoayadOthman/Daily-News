import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joby/consts/consts.dart';
import '../widgets/category_card.dart';
import '../widgets/news_card.dart';

class NewsDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> article; //  استلام بيانات المقالة الممررة
  const NewsDetailsScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // صورة المقالة
              if (article['urlToImage'] != null)
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        article['urlToImage'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 250,),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                        ),
                        IconButton(
                          onPressed: () {
                            // يمكنك إضافة وظيفة المشاركة هنا
                          },
                          icon: const Icon(Icons.share, color: Colors.white),
                        ),
                      ],
                    ),

                  ],
                ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.heightBox,
                    // عنوان المقالة
                    Text(
                      article['title'] ?? 'No Title',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    5.heightBox,
                    Container(
                      width: context.screenWidth * 0.4,
                      height: 5,
                      color: appColor,
                    ),
                    10.heightBox,

                    // مصدر المقالة وتاريخ النشر
                    Row(
                      children: [
                        const Icon(Icons.calendar_today_outlined, color:appColor, size: 16),
                        5.widthBox,
                        Text(
                          article['publishedAt'] ?? 'Unknown Date',
                          style: const TextStyle(color:appColor, fontSize: 13),
                        ),
                        5.widthBox,
                      ],
                    ),
                    10.heightBox,

                    // محتوى المقالة
                    Text(
                      article['description'] ?? 'No Description Available',
                      style: const TextStyle(fontSize: 16),
                    ),
                    10.heightBox,

                    Text(
                      article['content'] ?? 'No Content Available',
                      style: const TextStyle(fontSize: 14),
                    ),
                    10.heightBox,

                    // نصوص إضافية مثل "You may also like"
                    const Text(
                      'You may also like',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    5.heightBox,
                    Container(
                      width: context.screenWidth * 0.4,
                      height: 5,
                      color: appColor,
                    ),
                  ],
                ),
              ),


              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return  NewsCard(index: index,);
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
