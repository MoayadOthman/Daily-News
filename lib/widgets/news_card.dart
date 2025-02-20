import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joby/consts/colors.dart';
import '../controllers/news.dart';
import '../viwes/news_details_screen.dart';

class NewsCard extends StatelessWidget {
  final int index;

  NewsCard({Key? key, required this.index}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {

    final NewsController newsController = Get.find<NewsController>();

    return GestureDetector(
      onTap: () {
        //   الانتقال إلى صفحة التفاصيل وتمرير بيانات المقالة المحددة
        Get.to(() => NewsDetailsScreen(article:newsController.articles[index]));
      },
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(newsController.articles[index]['title'] ?? 'No Title'),
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: appColor,
                          ),
                          child: Text(
                            newsController.articles[index]['source']['name'] ?? 'Unknown Source',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: newsController.articles[index]['urlToImage'] != null
                        ? Image.network(
                      newsController.articles[index]['urlToImage'],
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                        : const Icon(Icons.image_not_supported),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          newsController.toggleLike(index); // تبديل حالة اللايك
                        },
                        icon: Obx(() => Icon(
                          newsController.likedArticles[index] == true
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: newsController.likedArticles[index] == true
                              ? Colors.red
                              : Colors.grey,
                        )),
                      ),
                      Obx(() => Text(
                        newsController.likedArticles[index] == true ? "Liked" : "",
                        style: TextStyle(
                          color: newsController.likedArticles[index] == true
                              ? Colors.red
                              : Colors.grey,
                        ),
                      )),
                    ],
                  ),                  Row(
                    children: [
                      const Icon(Icons.timer_outlined, color:appColor),
                      const SizedBox(width: 5),
                      Text(
                        newsController.articles[index]['publishedAt'] ?? 'Unknown Date',
                        style: const TextStyle(color:appColor),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
