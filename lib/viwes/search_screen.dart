import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../consts/colors.dart';
import '../controllers/news.dart';
import '../widgets/news_card.dart';

class SearchScreen extends StatelessWidget {
  final NewsController newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Latest News",style: TextStyle(color: appColor,fontSize: 30,fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: newsController.refreshNews,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: "Search for articles...",
                      focusedBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                              color: appColor,
                              )
                                 ),
                           enabledBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                              color: appColor,
                          )
                             ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            color: appColor,
                        )
                      ),

                    ),
                    //تخزين
                    onChanged: (inputValue) {
                      newsController.searchQuery.value = inputValue;
                    },
                  ),
                ),
                //تنفيذ
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: newsController.searchArticles,
                ),
              ],
            ),
          ),
          Obx(() {
            if (newsController.articles.isEmpty) {
              return const Center(
                child: Text("No articles available. Try refreshing or searching."),
              );
            } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: newsController.articles.length,
                  itemBuilder: (context, index) {
                    return NewsCard(index: index);
                  },
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
