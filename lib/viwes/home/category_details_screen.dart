import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joby/controllers/news.dart';
import '../../consts/colors.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final String categoryName;

  const CategoryDetailsScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final NewsController newsController=Get.put(NewsController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(categoryName,style: const TextStyle(color: appColor,fontSize: 30,fontWeight: FontWeight.bold),),
      ),
      body: FutureBuilder(
        //الوصول الى دالة احضار بيانات حسب التصنيف
        future: newsController.fetchNewsByCategory(categoryName.toLowerCase()), // جلب الأخبار بناءً على التصنيف
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
            return const Center(child: Text('No articles found'));
          } else {
            //    تخزين جميع المقالات المصنفة في قائمة
            final  articles = snapshot.data as List<dynamic>;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // عرض صورة المقال
                      if (articles[index]['urlToImage'] != null)
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          child: Image.network(
                            articles[index]['urlToImage'],
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 50),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // عنوان المقال
                            Text(
                              articles[index]['title'] ?? 'No Title',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            // وصف المقال
                            Text(
                              articles[index]['description'] ?? 'No Description',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 10),
                            // عرض وقت النشر والرابط
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (articles[index]['publishedAt'] != null)
                                  Row(
                                    children: [
                                      const Icon(Icons.access_time, size: 16, color:appColor),
                                      const SizedBox(width: 5),
                                      Text(
                                        articles[index]['publishedAt'].substring(0, 10), // عرض التاريخ فقط
                                        style: const TextStyle(fontSize: 14, color:appColor),
                                      ),
                                    ],
                                  ),
                                TextButton(
                                  onPressed: () {
                                    if (articles[index]['url'] != null) {
                                      // الانتقال إلى صفحة التفاصيل أو فتح الرابط في المتصفح
                                      Get.to(() => WebViewPage(url: articles[index]['url']));
                                    }
                                  },
                                  child: const Text('Read More',style: TextStyle(color: appColor,fontSize: 16),),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class WebViewPage extends StatelessWidget {
  final String url;

  WebViewPage({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Details'),
      ),
      body: Center(
        child: Text('WebView to load: $url'), // أو يمكنك إضافة WebView لعرض المقالة
      ),
    );
  }
}
